    Title: More Scripting With Racket
    Date: 2025-01-30T15:01:08
    Tags: Racket, Scripting, CrossPlatform, CodingRecipes

Using [racket](https://racket-lang.org) in a shell script to automate some repetitive commands.

<!-- more -->

Lately I've been looking at the [Zed editor](https://zed.dev) and being the sort of developer I am I wanted to see if I could get it just as nice in Windows as it is in Linux.

On Linux and Mac there's a nice prebuilt binary available.  They (the Zed folks) are working on a Windows port but for now a developer needs to built it his/herself from code.  By the way I've got to hand it to the Zed folks--once it's built it works very well on Windows.  So to run it on Windows, I need to change to the root of the Zed source tree and then use Rust's cargo tool to fire up the binary.  Being the lazy human being that I am I wanted to automate that so that I could easily fire off Zed from anywhere.  And being that I also love Racket I wanted to use my Powershell/Racket combo to automate things.  Well here's the result of that!

```powershell
; Racket.exe (Resolve-Path $PSCommandPath) $args
; Exit
#lang typed/racket/base

(require typed/racket/system)

(: ZED-PATH Path)
(define ZED-PATH (string->path "C:\\Users\\Public\\zed\\"))
(: CARGO-COMMAND-LINE String)
(define CARGO-COMMAND-LINE "cargo run --release")

(parameterize ((current-directory ZED-PATH)) (system CARGO-COMMAND-LINE))
```

A few comments about the script are in order I think:

1. As you may guess I'm a big fan of Typed Racket.  The two lines in front of the definitions of `ZED-PATH` and `CARGO-COMMAND-LINE` aren't strictly needed; they're just a way of expressing my intent.

2. The `parameterize` construct (which was pointed out to me by a few of the friendly folks of the Racket community) allows me to temporarily change to another directory, run what I want there and then the directory is changed back to the original directory when the scope of the parameterize ends.

3. In that `parameterize` function the function to be parameterized would normally be specified in this fashion `([current-directory ZED-PATH])`. However the square brackets are special characters to Powershell and Racket allows me to use paratheses there so rather than trying to figure out how to escape the square brackets I simply using parens instead.

4. The `system` function starts the command _synchronously_.  That is, it blocks until the command exits.  I wouldn't normally want it to be synchronous but the regular async option (at least as far as I know) in Racket is `process`.  While that seemed to work just fine as far as I could tell (I mean it looked as if everything were working as expected) it failed to actually start the binary for me.

5. There is a command parameter to `cargo` that should allow me to run the binary from any directory.  Again, though, for reasons I was unable to isolate I couldn't make it work correctly with this configuration.  So I simply live with having to change to the Zed source root directory while I run the command.

I just wanted to document this in case anyone else were interested!
