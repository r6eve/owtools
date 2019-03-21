(*
 *           Copyright r6eve 2019 -
 *  Distributed under the Boost Software License, Version 1.0.
 *     (See accompanying file LICENSE_1_0.txt or copy at
 *           https://www.boost.org/LICENSE_1_0.txt)
 *)

open OUnit2

module String = Owtools.Extensions.String

let quote_glob _test_ctxt =
  assert_equal "'foo*bar'" @@ String.quote_glob "foo*bar";
  assert_equal "foobar" @@ String.quote_glob "foobar"

let escape_html _test_ctxt =
  assert_equal "&#34;&#62;&#60;script&#62;alert(document.cookie)&#60;/script&#62;" @@
    String.escape_html "\"><script>alert(document.cookie)</script>"

let suite =
  "Extensions suite" >:::
     [ "quote_glob" >:: quote_glob
     ; "escape_html" >:: escape_html
     ]

let () =
  run_test_tt_main suite
