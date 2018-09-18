(*
TODO:
val locate : string
val make_locate_command : string list -> string
val make_locate_process : string list -> in_channel
val close_locate_process : in_channel -> unit
val sort_locate_hits : 'a list -> 'a list
val w3m_html_of_locate : string list -> string list
*)
val main : unit -> unit
