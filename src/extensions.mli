module List : sig
  include module type of List

  val last : 'a list -> 'a
end

module String : sig
  include module type of String

  val quote_wildcard : string -> string

  val escape_html : string -> string
end

module Sys : sig
  include module type of Sys

  val get_argv_list : unit -> string list

  val read_from_stdin : in_channel -> string list
end

module Unix : sig
  include module type of Unix

  val check_exit : string -> process_status -> unit
end
