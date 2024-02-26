(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

module List = Extensions.List
module String = Extensions.String
module Sys = Extensions.Sys
module Unix = Extensions.Unix

let rg = "RIPGREP_CONFIG_PATH= rg"

let match_word_color_regexp = Re.Perl.compile_pat "\x1b\\[31m(\x1b?.*?)\x1b"
let anchor_of_path_and_line_num_regexp = Re.Str.regexp "^\\([^:]+\\):\\([0-9]+\\)"

let get_max_length_env () =
  try
    let n = int_of_string @@ Sys.getenv "MAX_LENGTH" in
    Some n
  with
  | Not_found | Failure _ -> None

let make_rg_command opts =
  let quote_string_including_spaces s =
    if String.contains s ' ' then
      "'" ^ s ^ "'"
    else
      s
  in
  let opts = List.cons "--line-number --sort=path --color=always" @@ List.map quote_string_including_spaces opts in
  let opt = String.concat " " opts in
  rg ^ " " ^ opt

let make_rg_process opts =
  Unix.open_process_in @@ make_rg_command opts

let close_rg_process in_channel =
  Unix.check_exit rg @@ Unix.close_process_in in_channel

let is_reg_file path =
  try
    let stats = Unix.stat path in
    match stats.st_kind with
    | Unix.S_REG -> true
    | _ -> false
  with
  (* TODO: Avoid catch-all cases in pattern matches for readability. *)
  | _ -> false

let concat_filename filename ss =
  List.map (fun s -> filename ^ ":" ^ s) ss

let sort_rg_hits lst =
  (* TODO: Check if the `path` includes ':'. *)
  let split path =
    (* Aim at a specific target. *)
    let path = Re.replace_string Util.all_color_regexp ~by:"" path in
    match String.split_on_char ':' path with
    | filename :: n_str :: _ -> filename, int_of_string n_str
    | _ ->
      prerr_endline "error in sorting"; (* TODO: use [failwith] *)
      exit 1
  in
  let cmp x y =
    let (x_path, x_n) = split x in
    let (y_path, y_n) = split y in
    let ord = compare x_path y_path in
    if ord <> 0 then
      ord
    else
      compare x_n y_n
  in
  List.sort cmp lst

let set_max_length s =
  match get_max_length_env () with
  | Some n when String.length s >= n -> String.sub s 0 n ^ "<CUT>"
  | Some _ | None -> s

let w3m_html_of_rg lines =
  lines
  |> List.map @@ fun s ->
    (* TODO: Replace string by \1. *)
    let m =
      match Re.matches match_word_color_regexp s with
      | [] -> failwith "error in matching string"
      | hd :: _ -> hd
    in
    let by_bold = "<b>" ^ String.sub m 5 (String.length m - 6) ^ "</b>\x1b" in
    s
    |> set_max_length
    |> String.escape_html
    |> Re.replace_string match_word_color_regexp ~by:by_bold
    |> Re.replace_string Util.all_color_regexp ~by:""
    |> Re.Str.replace_first
       anchor_of_path_and_line_num_regexp
       "<a href=\"\\1#\\2\">\\0</a>"
    |> Util.flip ( ^ ) "<br>"

let main () =
  let argv_list = Sys.get_argv_list () in
  let last_arg = List.last argv_list in
  let proc = make_rg_process argv_list in
  let ss = List.rev @@ Sys.read_from_stdin proc in
  close_rg_process proc;
  let ss = if is_reg_file last_arg then concat_filename last_arg ss else ss in
  (* let ss = sort_rg_hits ss in *)
  let html = w3m_html_of_rg ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc
