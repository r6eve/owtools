module List = Extensions.List
module String = Extensions.String
module Sys = Extensions.Sys
module Unix = Extensions.Unix

let find = "find"

let make_find_command opts =
  opts
    |> List.map (fun s -> String.quote_glob s)
    |> List.cons find
    |> String.concat " "

let make_find_process opts =
  opts
    |> make_find_command
    |> Unix.open_process_in

let check_find_hits lst =
  if List.is_empty lst then exit 1
  else ()

let sort_find_hits lst =
  List.sort compare lst

let w3m_html_of_find lines =
  lines
    |> List.map (fun s ->
      let s = String.escape_html s in
      "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>")

let run () =
  let proc =
    Sys.get_argv_list ()
      |> make_find_process in
  let ss = Sys.read_from_stdin proc in
  (* Discard exit status. *)
  Unix.close_process_in proc |> ignore;
  check_find_hits ss;
  let ss = sort_find_hits ss in
  let html = w3m_html_of_find ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc
