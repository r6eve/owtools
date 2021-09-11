owtools
=======
[![Build Status][]][CI Results]

owtools include browsers for a terminal junker. The original idea is from [wgrep, wlocate, wfind - 兼雑記][original-idea].

## Changes from the Original

* Written in OCaml.
* Sort results by path in lexicographic order.
* Set the max length of matched results.

## Demo

### wag

[ag][] with w3m.

![wag-demo][]

### wfind

`find` with w3m. In addition, you can edit results.

![wfind-demo][]

### wlocate

[mlocate][] with w3m. In addition, you can edit results.

![wlocate-demo][]

## Requirements

* OCaml (>= 4.07.0)
* Dune
* ocaml-re
* w3m
* ag, find, mlocate

## Installation

### From source codes

```console
> opam update
> opam install dune ounit re qcheck
> git clone https://github.com/r6eve/owtools.git
> cd owtools
> make
> ls bin
wag*  wfind*  wlocate*

# Then, move those bins to PATH, or export PATH to add there.
```

### From executable binaries

See [Releases][]. `owtools-x86_64-unknown-linux-musl.tar.zst` includes
statically linked binaries.

## Useful Aliases and Functions

```bash
alias wa='MAX_LENGTH=300 wag -U --hidden --ignore-dir .git --ignore-dir _build'

wf(){ wfind "$@" -not -path '*/.git/*' -a -not -path '*/target/*' -a -not -path "*/_build/*" -a -type f }
```

[Build Status]: https://github.com/r6eve/owtools/workflows/main/badge.svg
[CI Results]: https://github.com/r6eve/owtools/actions
[original-idea]: http://shinh.hatenablog.com/entry/20070429/1177827792
[ag]: https://github.com/ggreer/the_silver_searcher
[mlocate]: https://pagure.io/mlocate
[wag-demo]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/wag.png
[wfind-demo]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/wfind.png
[wlocate-demo]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/wlocate.png
[Releases]: https://github.com/r6eve/owtools/releases
