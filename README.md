owtools
=======
[![Build Status][]][CI Results]

This repository includes a browser in terminal. The original is [wgrep, wlocate, wfind - 兼雑記][original].

## Changes from the Original

* Written in OCaml.
* Sort results by path in lexicographic order.

## Demo

Useful alias.

![fig1][]

Browse.

![fig2][]

Open file.

![fig3][]

Edit file (set your editor in `$HOME/.w3m/config`).

![fig4][]

## Requirements

* OCaml (>= 4.06.0)
* Dune
* ocaml-re
* w3m
* ag, find, mlocate

## Installation

```console
> opam switch 4.06.0
> opam install dune re
> git clone https://github.com/r6eve/owtools.git
> cd owtools
> make
> ls bin
wag*  wfind*  wlocate*
```

## Useful Aliases and Functions

```bash
alias wa='MAX_LENGTH=300 wag -U --hidden --ignore-dir .git --ignore-dir _build'

wf(){ wfind "$@" -not -path '*/.git/*' -a -not -path '*/target/*' -a -type f }
```

## Contributing

If you would like to help making this repository, take the following steps.

1. Fork this repository: https://github.com/r6eve/owtools/fork
2. Switch branches: `git checkout -b new-feature`
3. Do something.
4. Commits: `git commit -am 'add some feature'`
5. Push to your repository: `git push origin new-feature`
6. Send a pull request.

## Contributors

- [r6eve][] - Neat

[Build Status]: https://travis-ci.org/r6eve/owtools.svg?branch=master
[CI Results]: https://travis-ci.org/r6eve/owtools
[original]: http://shinh.hatenablog.com/entry/20070429/1177827792
[fig1]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/fig1.png
[fig2]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/fig2.png
[fig3]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/fig3.png
[fig4]: https://raw.githubusercontent.com/r6eve/screenshots/master/owtools/fig4.png
[r6eve]: https://github.com/r6eve
