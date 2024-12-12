; Racket (Resolve-Path $PSCommandPath) $args
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