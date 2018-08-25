(* TODO: Check if the command is installed. *)
let ag = "ag"

let w3m = "w3m"

let get_argv_list () =
  Sys.argv
  |> Array.to_list
  |> List.tl

let make_ag_command () =
  get_argv_list ()
  |> List.append [ag; "--color"]
  |> String.concat " "

let make_w3m_command () =
  [w3m; "-T"; "text/html"]
  |> String.concat " "

let () =
  let ic =
    make_ag_command ()
    |> Unix.open_process_in in
  let rec doit results =
    try
      input_line ic :: results
      |> doit
    with
    | End_of_file -> results in
  let results = doit [] in
  List.iter (fun s -> print_endline s) results;
  let exit_status = Unix.close_process_in ic in
  match exit_status with
  | Unix.WEXITED 0 -> ()
  | Unix.WEXITED n -> Printf.printf "The process terminated normally by [%d]\n" n
  | Unix.WSIGNALED n -> Printf.eprintf "The process was killed by [%d]\n" n
  | Unix.WSTOPPED n -> Printf.eprintf "The process was stopped by [%d]\n" n
