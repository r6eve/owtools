module Sys = Extensions.Sys
module Unix = Extensions.Unix

(* TODO: Check if the command is installed. *)
let locate = "locate"

let make_locate_command argv =
  argv
    |> List.cons locate
    |> String.concat " "

let sort_locate_hits lst =
  List.sort compare lst

let w3m_html_of_locate lines =
  lines
    |> List.map (fun s ->
      let s = Util.escape_html s in
      "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>")

let () =
  let ic =
    Sys.get_argv_list ()
      |> make_locate_command
      |> Unix.open_process_in in
  let ss = Sys.read_from_stdin ic in
  ic
    |> Unix.close_process_in
    |> Unix.check_exit "locate";
  let ss =
    ss
      |> sort_locate_hits
      |> w3m_html_of_locate in
  let oc =
    W3m.make_command ()
      |> Unix.open_process_out in
  ss
    |> List.iter (fun s -> output_string oc s);
  oc
    |> Unix.close_process_out
    |> Unix.check_exit "w3m"
