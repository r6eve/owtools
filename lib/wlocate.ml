(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

module String = Extensions.String
module Sys = Extensions.Sys
module Unix = Extensions.Unix

let locate = "locate"

let make_locate_command opts =
  String.concat " " @@ List.cons locate opts

let make_locate_process opts =
  Unix.open_process_in @@ make_locate_command opts

let close_locate_process in_channel =
  Unix.check_exit locate @@ Unix.close_process_in in_channel

let sort_locate_hits lst =
  List.sort compare lst

(* TODO: Duplicated function. *)
let w3m_html_of_locate lines =
  let a_href_br s =
    let s = String.escape_html s in
    "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>"
  in
  List.map a_href_br lines

let main () =
  let proc = make_locate_process @@ Sys.get_argv_list () in
  let ss = Sys.read_from_stdin proc in
  close_locate_process proc;
  let ss = sort_locate_hits ss in
  let html = w3m_html_of_locate ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc
