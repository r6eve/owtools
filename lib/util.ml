(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

let flip f x y = f y x

let some_of_x x = Some x

let all_color_regexp = Re.Perl.compile_pat "\x1b\\[(\\d*;?\\d*m|K)"
