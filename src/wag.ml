module Sys = Extensions.Sys
module Unix = Extensions.Unix

(* TODO: Check if the command is installed. *)
let ag = "ag"

let match_word_color_regexp = Re.Perl.compile_pat "\x1b\\[30;43m(\x1b?.*?)\x1b"
let anchor_of_path_and_line_num_regexp = Re.Str.regexp "^\\([^:]+\\):\\([0-9]+\\)"

let make_ag_command argv =
  argv
  |> List.append [ag; "--color"]
  |> String.concat " "

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

let w3m_html_of_ag_color lines =
  lines
  |> List.map (fun s ->
    (* TODO: Replace string by \1. *)
    let m =
      s
      |> Re.matches match_word_color_regexp
      |> List.hd in
    let by_str = "<b>" ^ String.sub m 8 (String.length m - 9) ^ "</b>\x1b" in
    s
    |> Re.replace_string match_word_color_regexp ~by:by_str
    |> Re.replace_string Util.all_color_regexp ~by:""
    |> Re.Str.replace_first anchor_of_path_and_line_num_regexp "<a href=\"\\1#\\2\">\\0</a>"
    |> Util.flip ( ^ ) "<br>")

let () =
  let ic =
    Sys.get_argv_list ()
    |> make_ag_command
    |> Unix.open_process_in in
  let ss = Sys.read_from_stdin ic in
  ic
  |> Unix.close_process_in
  |> Unix.check_exit "ag";
  let ss =
    ss
    |> List.map Util.escape_html
    |> sort_ag_hits
    |> w3m_html_of_ag_color in
  let oc =
    W3m.make_command ()
    |> Unix.open_process_out in
  ss
  |> List.iter (fun s -> output_string oc s);
  oc
  |> Unix.close_process_out
  |> Unix.check_exit "w3m"
