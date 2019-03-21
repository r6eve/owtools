(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

open OUnit2

module Util = Owtools.Util

let all_color_regexp _test_ctxt =
  assert_equal "foo" @@ Re.replace_string Util.all_color_regexp ~by:"" "foo";
  assert_equal "test/foo.ml:7:  QCheck.Test.make" @@
    Re.replace_string Util.all_color_regexp ~by:""
      "[1;32mtest/foo.ml[0m[K:[1;33m7[0m[K:  [30;43mQCheck[0m[K.Test.make"

let suite =
  "Util suite" >::: ["all_color_regexp" >:: all_color_regexp]

let () =
  run_test_tt_main suite
