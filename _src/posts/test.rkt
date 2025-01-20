```rkt
#lang typed/racket   ; I prefer typed racket where I can use it

(require qi)         ; The qi language/library provides excellent flow control for Racket.

(define (times-ten [n : Number])  (* n 10))
(define (turn-to-string [n : Number])  (number->string n))

(define (demonstrate-qi [n : Number]) (~> (n) times-ten turn-to-string)) ; the ~> is the qi pipe forward operator
```
