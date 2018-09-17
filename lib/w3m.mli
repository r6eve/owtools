val make_process : unit -> out_channel
(** Make w3m process for redirecting the standard input of the command to a
    pipe. *)

val output : out_channel -> string list -> unit
(** Write the list of strings on the given output channel. *)

val close_process : out_channel -> unit
(** Close w3m process. *)
