(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

module Unix = Extensions.Unix

let w3m = "w3m"

let make_command () =
  String.concat " " [w3m; "-T"; "text/html"]

let make_process () =
  Unix.open_process_out @@ make_command ()

let output out_channel ss =
  let output s = output_string out_channel s in
  List.iter output ss

let close_process out_channel =
  Unix.check_exit w3m @@ Unix.close_process_out out_channel
