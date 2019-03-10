(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c
(** flappers *)

val some_of_x : 'a -> 'a option
(** Convert from x to Some x. *)

val all_color_regexp : Re.re
(** Regular expression for 256 colors. *)
