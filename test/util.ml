(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

open Owtools

let () =
  assert (Re.replace_string Util.all_color_regexp ~by:"" "foo" = "foo");
  assert (
    Re.replace_string Util.all_color_regexp ~by:""
      "[1;32mtest/foo.ml[0m[K:[1;33m7[0m[K:  [30;43mQCheck[0m[K.Test.make"
    = "test/foo.ml:7:  QCheck.Test.make")
