val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c
(** flappers *)

val some_of_x : 'a -> 'a option
(** Convert from x to Some x. *)

val all_color_regexp : Re.re
(** Regular expression for 256 colors. *)
