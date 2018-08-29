module Sys = Extensions.Sys
module Unix = Extensions.Unix

(* TODO: Check if the command is installed. *)
let find = "find"

let make_find_command argv =
  argv
  |> List.cons find
  |> String.concat " "

let sort_find_hits lst =
  List.sort compare lst

let w3m_html_of_find lines =
  lines
  |> List.map (fun s ->
    let s = Util.escape_html s in
    "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>")

let () =
  let ic =
    Sys.get_argv_list ()
    |> make_find_command
    |> Unix.open_process_in in
  let ss = Sys.read_from_stdin ic in
  ic
  |> Unix.close_process_in
  |> Unix.check_exit "find";
  let ss =
    ss
    |> sort_find_hits
    |> w3m_html_of_find in
  let oc =
    W3m.make_command ()
    |> Unix.open_process_out in
  ss
  |> List.iter (fun s -> output_string oc s);
  oc
  |> Unix.close_process_out
  |> Unix.check_exit "w3m"
