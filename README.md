*NOT RELEASED*

o-wtools
========
[![Build Status][]][CI Results]

The original is [wgrep, wlocate, wfind - 兼雑記][original] .

## Changes

* Written in OCaml.
* Sort results by path in lexicographic order.

## Demo

## Requirements

* OCaml (>= 4.06.0)
* Dune
* w3m
* ag, find, mlocate, etc.

## Installation

```console
> opam switch 4.06.0
> opam install dune
> git clone https://github.com/r6eve/o-wtools.git
> cd o-wtools
> make
```

[Build Status]: https://travis-ci.org/r6eve/o-wtools.svg?branch=master
[CI Results]: https://travis-ci.org/r6eve/o-wtools
[original]: http://shinh.hatenablog.com/entry/20070429/1177827792
