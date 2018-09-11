(** Extensions of poor OCaml standard libraries. *)

module List : sig
  include module type of List

  val last : 'a list -> 'a
  (** Return the last element of the given list. Raise [Failure "last"] if the
      list is empty. *)
end

module String : sig
  include module type of String

  val quote_wildcard : string -> string
  (** Surround the given string with quotes. *)

  val escape_html : string -> string
  (** Escape the string of HTML format. i.e. replace those strings.
      &  =>  &#38;
      '  =>  &#39;
      '"'  =>  &#34;
      <  =>  &#60;
      >  =>  &#62; *)
end

module Sys : sig
  include module type of Sys

  val get_argv_list : unit -> string list
  (** Return the list of the command-line arguments of string. *)

  val read_from_stdin : in_channel -> string list
  (** Read strings from the given input channel, and return the list of
      string. *)
end

module Unix : sig
  include module type of Unix

  val check_exit : string -> process_status -> unit
  (** Check the exit status of the process name. There are three patterns.
      1. Do nothing when the process terminated normally by 0.
      2. Exit silently when the process terminated normally by not-zero.
      3. Print error message and exit when the process was killed by signal or
         stopped by signal. *)
end
