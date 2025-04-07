    Title: Even More Scripting With Racket
    Date: 2025-04-07T17:38:06
    Tags:Racket, Scripting, CrossPlatform, CodingRecipes

Extending my use of [racket](https://racket-lang.org) to allow my shell scripts to be parameterized.

<!-- more -->

Lately for various reasons, I've been trying to move stuff off of my C drive. As with most of us the C drive has become a bit of a chokepoint for me in terms of free space.  So I've had an external drive for a while (E:) and lately as I add stuff I've been shifting it over to my E: drive.

Some of you may recall that I was using Racket within Powershell to automate things.  So here's an update on that idea with some comments afterward.

```racket
; e:/usr/bin/Racket/Racket.exe (Resolve-Path $PSCommandPath) $args
; Exit

#lang typed/racket/base
(require typed/racket)

(define no-args-passed "n")
(define command-line-empty? (= (vector-length (current-command-line-arguments)) 0))

(: first-arg String)
(define first-arg (if (not command-line-empty?) (vector-ref (current-command-line-arguments) 0) no-args-passed))

(: zed-path String)
(define zed-path (if (string=? first-arg no-args-passed) "C:\\Users\\Public\\zed\\" first-arg))

(: ZED-PATH Path)
(define ZED-PATH (string->path zed-path))

(: ZED-UPDATE-CMD String)
(define ZED-UPDATE-CMD "git pull origin main")

(parameterize ((current-directory ZED-PATH)) (system ZED-UPDATE-CMD))
```

As you might guess I created a script to automate pulling down the most recent Zed source code.  However I initially had it on my C:.  So I modified my `zup.ps1` script to allow me to continue to pull the source to C or to specify a different location.  The current-command-line-arguments parameter (and the word "parameter" has a very specific meaning in Racket by the way) is set by Racket when I invoke the zup.ps1 script.  If I pass something on the command line it goes into the current-command-line-arguments parameter.  So further down where I define zed-path I check if no arguments were passed and if not I default to my C drive.

Some of you may be curious why no-args-passed is "n" instead of an empty string or even something else.  Something about Powershell's parsing refused to work correctly with "".  I couldn't figure it out and I have better things to do with my time than to try to figure it out.  I'll leave that as a job for future me.
