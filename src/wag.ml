(* TODO: Check if the command is installed. *)
let ag = "ag"

let w3m = "w3m"

let get_argv_list () =
  Sys.argv
  |> Array.to_list
  |> List.tl

let make_ag_command argv =
  argv
  |> List.append [ag; "--color"]
  |> String.concat " "

let make_w3m_command () =
  [w3m; "-T"; "text/html"]
  |> String.concat " "

let read_from_stdin input_channel =
  let rec doit acc =
    try
      input_line input_channel
      |> Util.flip List.cons acc
      |> doit
    with
    | End_of_file -> acc in
  doit []

let check_exit exit_status =
  match exit_status with
  | Unix.WEXITED 0 -> ()
  | Unix.WEXITED n -> (Printf.printf "The process terminated normally by [%d]\n" n; exit n)
  | Unix.WSIGNALED n -> (Printf.eprintf "The process was killed by [%d]\n" n; exit n)
  | Unix.WSTOPPED n -> (Printf.eprintf "The process was stopped by [%d]\n" n; exit n)

let sort_ag_hits lst =
  (* TODO: Check if the `path` includes ':'. *)
  let split path =
    (* Aim at a specific target. *)
    match
      path
      |> Re.replace_string Util.all_color_regexp ~by:""
      |> String.split_on_char ':'
    with
    | filename :: n_str :: _ -> (filename, int_of_string n_str)
    | _ -> (prerr_endline "error in sorting"; exit 1) in
  let cmp x y =
    let (x_path, x_n) = split x in
    let (y_path, y_n) = split y in
    let ord = compare x_path y_path in
    if ord <> 0 then ord
    else compare x_n y_n in
  List.sort cmp lst

let () =
  let ic =
    get_argv_list ()
    |> make_ag_command
    |> Unix.open_process_in in
  let inputs =
    ic
    |> read_from_stdin
    |> sort_ag_hits in
  List.iter (fun s -> print_endline s) inputs;
  Unix.close_process_in ic
  |> check_exit
