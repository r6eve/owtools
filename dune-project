(lang dune 1.10)
(name owtools)
(version 0.1.0)

(implicit_transitive_deps true)
(generate_opam_files true)
(license BSL-1.0)
(authors "r6eve <r6eve@acm.org>")
(maintainers "r6eve <r6eve@acm.org>")
(source (github r6eve/owtools))
(homepage "https://github.com/r6eve/owtools")

(package
 (name owtools)
 (depends
  (ocaml (>= 4.07.0))
  (dune :build)
  (ounit (>= 2.0.8))
  re)
 (synopsis "Browser commands for terminal junkers"))
