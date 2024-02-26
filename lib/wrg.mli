(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

val match_word_color_regexp : Re.re
(** Regular expression to match words for searching. *)

val anchor_of_path_and_line_num_regexp : Re.Str.regexp
(** Regular expression to match words for all colors in terminal. *)

val get_max_length_env : unit -> int option
(** Return max length variable in environment variables. If no value is set,
    return None. *)

(*
TODO:
val make_rg_command : string list -> string
val make_rg_process : string list -> in_channel
val close_rg_process : in_channel -> unit
*)

val is_reg_file : string -> bool
(** Return true if the given path is a regular file, otherwise false. *)

val concat_filename : string -> string list -> string list
(** Return a list of strings where a string concatenates a filename in head. *)

val sort_rg_hits : string list -> string list
(** Return sorted results of `rg` hits. It is sorted by path in lexicographic
    order and line number in numerical order. *)

val set_max_length : string -> string
(** Return a substring of the given string which has length `max length`,
    itself if no value is set. *)

val w3m_html_of_rg : string list -> string list
(** Return a html list of w3m strings which are converted from `rg` strings. *)

val main : unit -> unit
(** This is a main function used in executable code. *)
