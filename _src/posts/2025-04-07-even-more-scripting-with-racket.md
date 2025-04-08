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

(define no-args-passed "")
(define command-line-empty? (= (vector-length (current-command-line-arguments)) 0))

(: first-arg String)
(define first-arg (if (not command-line-empty?) (vector-ref (current-command-line-arguments) 0) no-args-passed))

(: DEFAULT-ZED-SOURCE-PATH String)
(define DEFAULT-ZED-SOURCE-PATH "E:\\zed")

(: zed-source-path String)
(define zed-source-path (if (string=? first-arg no-args-passed) DEFAULT-ZED-SOURCE-PATH first-arg))

(: ZED-GIT-DIR Path)
(define ZED-GIT-DIR (string->path zed-source-path))

(: ZED-UPDATE-CMD String)
(define ZED-UPDATE-CMD "git pull origin main")

(parameterize ((current-directory ZED-GIT-DIR)) (system ZED-UPDATE-CMD))
```

As you might guess I created a script to automate pulling down the most recent Zed source code.  However I initially had it on my C:.  So I modified my `zup.ps1` script to allow me to pull the source to E or to specify a different location. I can pass a directory on the command line but if I don't it's defaulted to `DEFAULT-ZED-SOURCE-PATH`. The `current-command-line-arguments` parameter (and the word ["parameter"](https://docs.racket-lang.org/reference/parameters.html) has a very specific meaning in Racket by the way) is set by Racket when I invoke the zup.ps1 script.  If I pass something on the command line it goes into the current-command-line-arguments parameter.  So further down where I define zed-path I check if no arguments were passed and if not I default to my E drive.

----
EDIT: It was pointed out to me by one of the knowledgeable Racket folks that Racket has a very nice library for dealing with command lines. I thought about using it but in this case since I'm only dealing with one unnamed parameter it just seemed like it would be overengineering a solution.
