module Unix = Extensions.Unix

(* TODO: Check if the command is installed. *)
let w3m = "w3m"

let make_command () =
  String.concat " " [w3m; "-T"; "text/html"]

let make_process () =
  make_command ()
    |> Unix.open_process_out

let output out_channel ss =
  ss
    |> List.iter (fun s -> output_string out_channel s)

let close_process out_channel =
  out_channel
    |> Unix.close_process_out
    |> Unix.check_exit "w3m"
