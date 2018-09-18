module List = Extensions.List
module String = Extensions.String
module Sys = Extensions.Sys
module Unix = Extensions.Unix

let ag = "ag"

let match_word_color_regexp = Re.Perl.compile_pat "\x1b\\[30;43m(\x1b?.*?)\x1b"
let anchor_of_path_and_line_num_regexp = Re.Str.regexp "^\\([^:]+\\):\\([0-9]+\\)"

let get_max_length_env () =
  try
    "MAX_LENGTH"
      |> Sys.getenv
      |> int_of_string
      |> Util.some_of_x
  with
  | Not_found
  | Failure _ -> None

let quote_string_including_spaces s =
  if String.contains s ' ' then "'" ^ s ^ "'"
  else s

let make_ag_command opts =
  opts
    |> List.map (fun s -> quote_string_including_spaces s)
    |> List.append [ag; "--color"]
    |> String.concat " "

let make_ag_process opts =
  opts
    |> make_ag_command
    |> Unix.open_process_in

let close_ag_process in_channel =
  in_channel
    |> Unix.close_process_in
    |> Unix.check_exit "ag"

let reg_file_p path =
  try
    let stats = Unix.stat path in
    match stats.st_kind with
    | Unix.S_REG -> true
    | _ -> false
  with
  | _ -> false

let concat_filename filename ss =
  List.map (fun s -> filename ^ ":" ^ s) ss

let sort_ag_hits lst =
  (* TODO: Check if the `path` includes ':'. *)
  let split path =
    (* Aim at a specific target. *)
    match
      path
        |> Re.replace_string Util.all_color_regexp ~by:""
        |> String.split_on_char ':'
    with
    | filename :: n_str :: _ -> (filename, int_of_string n_str)
    | _ -> (prerr_endline "error in sorting"; exit 1) in
  let cmp x y =
    let (x_path, x_n) = split x in
    let (y_path, y_n) = split y in
    let ord = compare x_path y_path in
    if ord <> 0 then ord
    else compare x_n y_n in
  List.sort cmp lst

let set_max_length s =
  match get_max_length_env () with
  | Some n when String.length s >= n -> String.sub s 0 n ^ "<CUT>"
  | _ -> s

let w3m_html_of_ag lines =
  lines
    |> List.map (fun s ->
      (* TODO: Replace string by \1. *)
      let m =
        match Re.matches match_word_color_regexp s with
        | [] -> failwith "error in matching string"
        | hd :: _ -> hd in
      let by_bold = "<b>" ^ String.sub m 8 (String.length m - 9) ^ "</b>\x1b" in
      s
        |> set_max_length
        |> String.escape_html
        |> Re.replace_string match_word_color_regexp ~by:by_bold
        |> Re.replace_string Util.all_color_regexp ~by:""
        |> Re.Str.replace_first anchor_of_path_and_line_num_regexp "<a href=\"\\1#\\2\">\\0</a>"
        |> Util.flip ( ^ ) "<br>")

let main () =
  let argv_list = Sys.get_argv_list () in
  let last_arg = List.last argv_list in
  let proc = make_ag_process argv_list in
  let ss = Sys.read_from_stdin proc in
  close_ag_process proc;
  let ss =
    if reg_file_p last_arg then concat_filename last_arg ss
    else ss in
  let ss = sort_ag_hits ss in
  let html = w3m_html_of_ag ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc