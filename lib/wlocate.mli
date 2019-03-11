(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

(*
TODO:
val make_locate_command : string list -> string
val make_locate_process : string list -> in_channel
val close_locate_process : in_channel -> unit
*)

val sort_locate_hits : 'a list -> 'a list
(** Return sorted results of `locate` hits. It is sorted by path in
    lexicographic order. *)

val w3m_html_of_locate : string list -> string list
(** Return a html list of w3m strings which are converted from `locate`
    strings. *)

val main : unit -> unit
(** This is a main function used in executable code. *)
