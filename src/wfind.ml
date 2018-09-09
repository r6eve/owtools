module String = Extensions.String
module Sys = Extensions.Sys
module Unix = Extensions.Unix

(* TODO: Check if the command is installed. *)
let find = "find"

let make_find_command opts =
  opts
    |> List.map (fun s ->
      if String.contains s '*' then String.quote_wildcard s else s)
    |> List.cons find
    |> String.concat " "

let make_find_process opts =
  opts
    |> make_find_command
    |> Unix.open_process_in

let sort_find_hits lst =
  List.sort compare lst

let w3m_html_of_find lines =
  lines
    |> List.map (fun s ->
      let s = Util.escape_html s in
      "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>")

let () =
  let proc =
    Sys.get_argv_list ()
      |> make_find_process in
  let ss = Sys.read_from_stdin proc in
  (* Discard exit status. *)
  let _ = Unix.close_process_in proc in
  let ss = sort_find_hits ss in
  let html = w3m_html_of_find ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc
