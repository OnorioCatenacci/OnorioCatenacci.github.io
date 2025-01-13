    Title: Exercises for Chapter 2.1 HTDP
    Date: 2025-01-13T12:31:36
    Tags: Learning, SoftwareEngineering, HtDP

My answers for the exercises in Chapter 2 Section 1 of [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html). 

<!-- more -->

```racket
#lang htdp/bsl

(require 2htdp/image)

; Exercise 11 pg 53
(define (cartesian-distance x y) (sqrt (+ (* x x) (* y y))))

; Exercise 12 pg 53
(define (cvolume side-length) (* side-length side-length side-length))
(define (csurface side-length) (* 6 (* side-length side-length)))

; Exercise 13 pg 53
(define (string-empty? string) (= (string-length string) 0))

(define (string-first string) (if (not (string-empty? string)) (string-ith string 0) ""))

; Exercise 14 pg 53
; last-position-of-string assumes that the calling code will check the string to ensure it's not empty!
(define (last-position-of-string string) (- (string-length string) 1))
(define (string-last string) (if (not (string-empty? string)) (string-ith string (last-position-of-string string)) ""))

; Exercise 15 pg 53
(define (==> sunny friday) (or (not sunny) friday))

; Exercise 16 pg 53
(define (image-area image) (* (image-height image) (image-width image)))

; Exercise 17 pg 53
(define (image-classify image) 
  (cond
    [(> (image-height image) (image-width image)) "tall"]
    [(< (image-height image) (image-width image)) "wide"]
    [(= (image-height image) (image-width image)) "square"]))

; Exercise 18 pg 53
(define (string-join left-string right-string) (string-append left-string "_" right-string))

; Exercise 19 pg 53
; Note, per the text we do not confirm that position is actually contained in the string! 
(define (string-insert string position) (string-append (substring string 0 position) "_" (substring string position (string-length string))))

; Exercise 20 pg 54
; Note, again, per the text we do not confirm that the position is actually contained in the string!  Also note that we don't bother to check for an empty string being passed!
(define (string-delete string position)
  (cond
    [(= position 0) (substring string 1 (string-length string))]
    [(= position (string-length string)) (substring string 0 (- (string-length string) 1))]
    [(> position 0) (string-append (substring string 0 position) (substring string (+ position 1) (string-length string)))]))
```

I'm not happy with my answer for Exercise 20; it feels like there should be a simpler solution and it's just eluding me.  But, for whatever it's worth, here's my answers.

**Edit:** Yep, just looking at my answers it occurs to me that I defined a `last-position-of-string` function which I could have used in exercise 20 but didn't.  Mea culpa.  I'll leave this as is so that others might benefit from my oversight.
