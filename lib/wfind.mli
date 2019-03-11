(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

(*
TODO:
val make_find_command : string list -> string
val make_find_process : string list -> in_channel
val check_find_hits : 'a list -> unit
*)

val sort_find_hits : 'a list -> 'a list
(** Return sorted results `find` hits. It is sorted by path in lexicographical
    order. *)

val w3m_html_of_find : string list -> string list
(** Return a html list of w3m strings which are converted from `find`
    strings. *)

val main : unit -> unit
(** This is a main function used in executable code. *)
