    Title: Exercises 80 and 81 From How To Design Programs
    Date: 2025-01-28T15:50:08
    Tags: Learning, SoftwareEngineering, HtDP

My responses for Exercises 80 and 81 (Chapter 5.8) of [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html)

<!-- more -->

```racket
#lang typed/racket

; A 3d point structure
; r3 : Number Number Number -> r3
; r3 : Number -> Number -> Number -> r3
(require typed/rackunit)


(struct r3 ([x : Number] [y : Number] [z : Number]))
(define ex1 (r3 3 4 0))
(define ex2 (r3 2 10 11))

(: distance-to-origin (r3 -> Number))
(define (distance-to-origin r)
  (sqrt (+ (sqr (r3-x r)) (sqr (r3-y r)) (sqr (r3-z r)))))

(check-equal? (distance-to-origin ex1) 5 "distance-to-origin is not as expected")
(check-equal? (distance-to-origin ex2) 15 "distance-to-origin is not as expected")

; 5.8 Exercise 80

; movie is (movie String String Number)
(struct movie ([title : String] [producer : String] [year : Number]))

; movie-produced-by? : movie -> Boolean
(: movie-produced-by? (-> movie String Boolean))
(define (movie-produced-by? movie producer-name)
  (string=? (movie-producer movie) producer-name))

(define star-wars (movie "Star Wars" "George Lucas" 1977))
(define was-produced-by-Lucas (movie-produced-by? star-wars "George Lucas"))
(check-equal? (movie-produced-by? star-wars "George Lucas") #t)
(check-equal? (movie-produced-by? star-wars "Steven Spielberg") #f)
; check-pred seems more appropriate here but it doesn't seem to play well with TR.

; 5.8 Exercise 81
;time-since-midnight is (time-since-midnight Number Number Number)
(struct time-since-midnight ([hour : Number] [minute : Number] [second : Number]))

; Take TIME-SINCE-MIDNIGHT and return equivalent number of seconds
; time-since-midnight -> seconds
;
(: time->seconds (-> time-since-midnight Number))
(define (time->seconds time)
  (+ (* (time-since-midnight-hour time) 3600)
     (* (time-since-midnight-minute time) 60)
     (time-since-midnight-second time)))

(check-equal? (time->seconds (time-since-midnight 0 23 30)) 1410)
(check-equal? (time->seconds (time-since-midnight 10 12 25)) 36745)
```

Again, not restricting myself to BSL (even though that's what they use in HtDP).  Hence I'm using RackUnit for my unit testing and Typed Racket to do some type checking.
