(****************************************************************)
(*                                                              *)
(*           Copyright r6eve 2019 -                             *)
(*  Distributed under the Boost Software License, Version 1.0.  *)
(*     (See accompanying file LICENSE_1_0.txt or copy at        *)
(*           https://www.boost.org/LICENSE_1_0.txt)             *)
(*                                                              *)
(****************************************************************)

open Owtools
module String = Extensions.String

let () =
  assert (String.quote_glob "foo*bar" = "'foo*bar'");
  assert (String.quote_glob "foobar" = "foobar");
  assert (
    String.escape_html "\"><script>alert(document.cookie)</script>"
    = "&#34;&#62;&#60;script&#62;alert(document.cookie)&#60;/script&#62;")
