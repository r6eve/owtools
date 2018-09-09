let flip f x y = f y x

let all_color_regexp = Re.Perl.compile_pat "\x1b\\[(\\d*;?\\d*m|K)"
