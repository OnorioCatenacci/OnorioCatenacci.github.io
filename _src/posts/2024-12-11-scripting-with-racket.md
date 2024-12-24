    Title: Scripting With Racket
    Date: 2024-12-11T17:13:20
    Tags: Racket, Scripting, CrossPlatform, CodingRecipes

Using [racket](https://racket-lang.org) in a shell script allows a developer to basically use a lot of the same code across platforms.  
<!-- more -->
So I've begun blogging with Frog (as you can see) which is an excellent static site tool available with Racket.  One thing I discovered early on is that while I don't think there should be a problem with blogging from Linux or Windows, Frog isn't quite so easily pursuaded. After a little digging I was able to find that all I needed to do is to delete the build file placed under the .frog directory in my source tree.  Being a developer I hate taking more work than I need to.  So I started digging into how I can automate this task.  And the scripting story for Racket is great. 

In the Racket guide [here](https://docs.racket-lang.org/guide/scripts.html) there's a great pointer to how to create shell script in Linux and a batch file on Windows.  But I hate that people are still using batch files on Windows after Powershell has been available for at least a decade.  So I did a little digging and figured out how to do this task with Powershell too.  Here's the Linux script

```zsh
#! /usr/local/bin/racket
#lang typed/racket/base

; Set everything up first
(: base-frog-dir Path)
(define base-frog-dir (string->path "OnorioCatenacci.github.io"))
(: home-dir Path)
(define home-dir (find-system-path (quote home-dir)))
(: hidden-frog-build-dir Path)
(define hidden-frog-build-dir (string->path ".frog"))
(: frog-build-dir Path)
(define frog-build-dir (string->path "build"))
(: full-frog-path Path)
(define full-frog-path (build-path home-dir base-frog-dir hidden-frog-build-dir frog-build-dir))

; Now we finally go ahead and delete the build file
(delete-file full-frog-path)
```

Now, here's the extremely nice thing.  Here's that same script in Powershell:

```powershell
; Racket.exe (Resolve-Path $PSCommandPath) $args
; Exit
#lang typed/racket/base

; Set everything up first
(: base-frog-dir Path)
(define base-frog-dir (string->path "OnorioCatenacci.github.io"))
(: home-dir Path)
(define home-dir (find-system-path (quote home-dir)))
(: hidden-frog-build-dir Path)
(define hidden-frog-build-dir (string->path ".frog"))
(: frog-build-dir Path)
(define frog-build-dir (string->path "build"))
(: full-frog-path Path)
(define full-frog-path (build-path home-dir base-frog-dir hidden-frog-build-dir frog-build-dir))

; Now we finally go ahead and delete the build file
(delete-file full-frog-path)
```

See the difference?  The first two lines.  That's it.  That's all. 

You may notice that I needed to use the quote function in the definition of home-dir.  This is solely conditioned by the fact that a single quote has special meaning in Powershell.  Using `quote` allows me to work around this limitation.  The nice thing is that I can leave it that way on Linux and in the Windows batch file and it works just fine! 

And finally just for sake of completeness:

```batch
; @echo off
; Racket.exe "%~f0" %*
; exit /b
#lang typed/racket/base

; Set everything up first
(: base-frog-dir Path)
(define base-frog-dir (string->path "OnorioCatenacci.github.io"))
(: home-dir Path)
(define home-dir (find-system-path (quote home-dir)))
(: hidden-frog-build-dir Path)
(define hidden-frog-build-dir (string->path ".frog"))
(: frog-build-dir Path)
(define frog-build-dir (string->path "build"))
(: full-frog-path Path)
(define full-frog-path (build-path home-dir base-frog-dir hidden-frog-build-dir frog-build-dir))

; Now we finally go ahead and delete the build file
(delete-file full-frog-path)
```

The ability to reuse basically the same scripts in three different shell scripting systems is a win to me.  I don't have a Mac handy to test but I'm sure that the only change that I'd need would be the shebang lines at the top of the script.  

### EDIT
It occurs to me that others might mistake my intent to be complete in type specifications as being necessary.  It isn't.  Here's the version of the PS script with the type specifications removed so Typed Racket can infer the types.  This works equally well and it's a bit shorter. 

```powershell
; Racket.exe (Resolve-Path $PSCommandPath) $args
; Exit
#lang typed/racket/base

; Set everything up first
(define base-frog-dir (string->path "OnorioCatenacci.github.io"))
(define home-dir (find-system-path (quote home-dir)))
(define hidden-frog-build-dir (string->path ".frog"))
(define frog-build-dir (string->path "build"))
(define full-frog-path (build-path home-dir base-frog-dir hidden-frog-build-dir frog-build-dir))

; Now we finally go ahead and delete the build file
(delete-file full-frog-path)
```

