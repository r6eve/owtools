(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

module Unix = Extensions.Unix

let w3m = "w3m"

let make_command () =
  String.concat " " [w3m; "-T"; "text/html"]

let make_process () =
  make_command ()
    |> Unix.open_process_out

let output out_channel ss =
  ss
    |> List.iter (fun s -> output_string out_channel s)

let close_process out_channel =
  out_channel
    |> Unix.close_process_out
    |> Unix.check_exit "w3m"
