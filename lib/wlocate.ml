(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

module String = Extensions.String
module Sys = Extensions.Sys
module Unix = Extensions.Unix

let locate = "locate"

let make_locate_command opts =
  opts
    |> List.cons locate
    |> String.concat " "

let make_locate_process opts =
  opts
    |> make_locate_command
    |> Unix.open_process_in

let close_locate_process in_channel =
  in_channel
    |> Unix.close_process_in
    |> Unix.check_exit "locate"

let sort_locate_hits lst =
  List.sort compare lst

let w3m_html_of_locate ss =
  ss
    |> List.map (fun s ->
      let s = String.escape_html s in
      "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>")

let main () =
  let proc =
    Sys.get_argv_list ()
      |> make_locate_process in
  let ss = Sys.read_from_stdin proc in
  close_locate_process proc;
  let ss = sort_locate_hits ss in
  let html = w3m_html_of_locate ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc
