    Title: Exercise 58 HtDP
    Date: 2025-01-20T15:59:14
    Tags: Learning, SoftwareEngineering, HtDP

My answers for the exercises in Chapter 4.6 Exercise 58 of [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html).

<!-- more -->

```racket
; Price -> Number
; computes the sales tax charged for price
(define LOW-TAX-RATE 0)
(define LTR-LOWER-BOUND 0)
(define LTR-UPPER-BOUND 1000)
(define MIDDLE-TAX-RATE 0.05)
(define MTR-LOWER-BOUND LTR-UPPER-BOUND)
(define MTR-UPPER-BOUND 10000)
(define HIGH-TAX-RATE 0.08)
(define HTR-LOWER-BOUND MTR-UPPER-BOUND)

(check-expect (sales-tax 0) LOW-TAX-RATE)
(check-expect (sales-tax 537) LOW-TAX-RATE)
(check-expect (sales-tax 1000) (* MIDDLE-TAX-RATE 1000))
(check-expect (sales-tax 9999) (* MIDDLE-TAX-RATE 9999))
(check-expect (sales-tax 10000) (* HIGH-TAX-RATE 10000))
(check-expect (sales-tax 12017) (* HIGH-TAX-RATE 12017))

(define (sales-tax price)
  (cond
    [(and (>= price LTR-LOWER-BOUND) (< price LTR-UPPER-BOUND)) LOW-TAX-RATE]
    [(and (>= price MTR-LOWER-BOUND) (< price MTR-UPPER-BOUND)) (* price MIDDLE-TAX-RATE)]
    [(>= price HTR-LOWER-BOUND) (* price HIGH-TAX-RATE)]
    ))

```

A few words of explanation to help clear some possible confusion:

* I hard coded MTR-LOWER-BOUND as LTR-UPPER-BOUND; likewise with HTR-LOWER-BOUND. I did it in this way because initially they're the same; however if someone needs to change them in the future, they're separated as differing values.

* I considered using the upper/lower bounds inside my unit tests but I don't think that would be wise.  Using the bound constant definitions in the test itself may hide issues with the code.
