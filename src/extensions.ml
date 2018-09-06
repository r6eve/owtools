module List = struct
  include List

  let last l =
    let rec doit l =
      match l with
      | [] -> failwith "last"
      | [a] -> a
      | _ :: l -> doit l in
    doit l
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
        input_line input_channel
        |> Util.flip List.cons acc
        |> doit
      with
      | End_of_file -> acc in
    doit []
end

module Unix = struct
  include Unix

  let check_exit process exit_status =
    match exit_status with
    | Unix.WEXITED 0 -> ()
    | Unix.WEXITED n -> begin
      (* Exit silently when the process terminated normally. *)
      exit n
    end
    | Unix.WSIGNALED n -> (Printf.eprintf "The `%s` was killed by [%d]\n" process n; exit n)
    | Unix.WSTOPPED n -> (Printf.eprintf "The `%s` was stopped by [%d]\n" process n; exit n)
end
