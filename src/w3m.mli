val make_process : unit -> out_channel

val output : out_channel -> string list -> unit

val close_process : out_channel -> unit
