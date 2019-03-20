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

let find = "find"

let make_find_command opts =
  let opts = List.map String.quote_glob opts in
  let opt = String.concat " " opts in
  find ^ " " ^ opt

let make_find_process opts =
  Unix.open_process_in @@ make_find_command opts

let check_find_hits lst =
  if List.is_empty lst then
    exit 1
  else
    ()

let sort_find_hits lst =
  List.sort compare lst

(* TODO: Duplicated function. *)
let w3m_html_of_find lines =
  let a_href_br s =
    let s = String.escape_html s in
    "<a href=\"" ^ s ^ "\">" ^ s ^ "</a><br>"
  in
  List.map a_href_br lines

let main () =
  let proc = make_find_process @@ Sys.get_argv_list () in
  let ss = Sys.read_from_stdin proc in
  (* Discard exit status. *)
  ignore @@ Unix.close_process_in proc;
  check_find_hits ss;
  let ss = sort_find_hits ss in
  let html = w3m_html_of_find ss in
  let proc = W3m.make_process () in
  W3m.output proc html;
  W3m.close_process proc
