    Title: Exercise 72 From How To Design Programs
    Date: 2025-01-23T14:09:01
    Tags: Learning, SoftwareEngineering, HtDP

My response for Exercises 72 and 73 (Chapter 5.6) of [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html)

<!-- more -->

```racket
#lang typed/racket

; Exercise 72
(struct phone-number ([area : String] [switch : String] [num : String]))
(struct entry ([name : String] [phone : phone-number] [email : String]))

; Exercise 73
(struct posn ([x : Number] [y : Number]))

(: posn-up-x (-> posn Number posn))
(define (posn-up-x p n)
  (posn (+ (posn-x p) n) (posn-y p)))
```

I'm using Typed Racket here rather than BSL because unless I need to do some graphic work I don't see any reason to solve the problems in BSL since that's ultimately a dead end.
