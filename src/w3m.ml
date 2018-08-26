(* TODO: Check if the command is installed. *)
let w3m = "w3m"

let make_command () =
  String.concat " " [w3m; "-T"; "text/html"]
