    Title: Another Exercise From HTDP
    Date: 2025-01-10T11:46:08
    Tags: Learning, SoftwareEngineering, HtDP

Another exercise from Chapter 1 of [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html). 

<!-- more -->

My answer for exercise 9 in Chapter 1.

```racket
(define (in expression)
  (cond
    [(string? expression) (string-length expression)]
    [(image? expression) (* (image-height expression) (image-width expression))]
    [(number? expression)
     (if (<= expression 0)
         expression
         (- expression 1))]
    [(boolean? expression) (if expression 10 20)]))
```

A few more points lest I forget:

1. It's very handy to format your racket code.  Simply use raco to install the fmt package (`raco pkg install fmt`).  Once you do that the command line is something like: `raco fmt --width #your_preferred_maxwidth --indent #your_preferred_indentation -i #racket_source_file`. In my case it's this `raco fmt --width 80 --indent 3 -i htdp_chapter1_ex9.rkt`.

2. Make sure if you do anything in DrRacket that you save your definitions as _text_.  Otherwise the formatter won't be able to do a thing with the source. Saving as text is under the `Save Other` menu in DrRacket. 