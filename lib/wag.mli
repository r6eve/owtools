(*
TODO:
val ag : string
val match_word_color_regexp : Re.re
val anchor_of_path_and_line_num_regexp : Re.Str.regexp
val get_max_length_env : unit -> int option
val quote_string_including_spaces : string -> string
val make_ag_command : string list -> string
val make_ag_process : string list -> in_channel
val close_ag_process : in_channel -> unit
val reg_file_p : string -> bool
val concat_filename : string -> string list -> string list
val sort_ag_hits : string list -> string list
val set_max_length : string -> string
val w3m_html_of_ag : string list -> string list
*)
val main : unit -> unit
