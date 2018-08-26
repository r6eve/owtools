let flip f x y = f y x

let all_color_regexp = Re.Perl.compile_pat "\x1b\\[(\\d*;?\\d*m|K)"
let match_word_color_regexp = Re.Perl.compile_pat "\x1b\\[30;43m(\x1b?.*?)\x1b"

let apostrophe = Re.Perl.compile_pat "'"
let quotedbl = Re.Perl.compile_pat "\""
let ampersand = Re.Perl.compile_pat "&"
let less = Re.Perl.compile_pat "<"
let greater = Re.Perl.compile_pat ">"

let escape_html str =
  str
  |> Re.replace_string apostrophe ~by:"&#39;"
  |> Re.replace_string quotedbl ~by:"&#34;"
  |> Re.replace_string ampersand ~by:"&#38;"
  |> Re.replace_string less ~by:"&#60;"
  |> Re.replace_string greater ~by:"&#62;"
