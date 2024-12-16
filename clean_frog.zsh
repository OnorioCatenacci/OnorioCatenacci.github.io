#! /usr/bin/racket
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