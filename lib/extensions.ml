(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

module List = struct
  include List

  let is_empty l =
    match l with
    | [] -> true
    | _ -> false

  let last l =
    let rec doit l =
      match l with
      | [] -> failwith "last"
      | [a] -> a
      | _ :: l -> doit l in
    doit l
end

module CharSet = Set.Make(
  struct
    type t = char
    let compare a b = Char.code a - Char.code b
  end)

let glob_set = CharSet.of_list ['*'; '?'; '['; ']']

let ampersand = Re.Perl.compile_pat "&"
let apostrophe = Re.Perl.compile_pat "'"
let quotedbl = Re.Perl.compile_pat "\""
let less = Re.Perl.compile_pat "<"
let greater = Re.Perl.compile_pat ">"

module String = struct
  include String

  let quote_glob s =
    let n = String.length s in
    let rec doit i =
      if i = n then s
      else if CharSet.mem (String.get s i) glob_set then "'" ^ s ^ "'"
      else doit (i + 1) in
    doit 0

  let escape_html str =
    str
      |> Re.replace_string ampersand ~by:"&#38;"
      |> Re.replace_string apostrophe ~by:"&#39;"
      |> Re.replace_string quotedbl ~by:"&#34;"
      |> Re.replace_string less ~by:"&#60;"
      |> Re.replace_string greater ~by:"&#62;"
end

module Sys = struct
  include Sys

  let get_argv_list () =
    Sys.argv
      |> Array.to_list
      |> List.tl

  let read_from_stdin input_channel =
    let rec doit acc =
      try
        input_channel
          |> input_line
          |> Util.flip List.cons acc
          |> doit
      with
        End_of_file -> acc in
    doit []
end

module Unix = struct
  include Unix

  let check_exit process exit_status =
    match exit_status with
    | Unix.WEXITED 0 -> ()

    | Unix.WEXITED n ->
      (* Exit silently when the process terminated normally. *)
      exit n

    | Unix.WSIGNALED n ->
      begin
        Printf.eprintf "The `%s` was killed by [%d]\n" process n;
        exit n
      end

    | Unix.WSTOPPED n ->
      begin
        Printf.eprintf "The `%s` was stopped by [%d]\n" process n;
        exit n
      end
end
