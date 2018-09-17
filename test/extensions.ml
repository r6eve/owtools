open Owtools
module String = Extensions.String

let () =
  assert (String.quote_glob "foo*bar" = "'foo*bar'");
  assert (String.quote_glob "foobar" = "foobar");
  assert (
    String.escape_html "\"><script>alert(document.cookie)</script>"
    = "&#34;&#62;&#60;script&#62;alert(document.cookie)&#60;/script&#62;")
