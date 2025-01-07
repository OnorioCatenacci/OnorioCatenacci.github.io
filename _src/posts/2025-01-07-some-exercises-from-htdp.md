    Title: Some Exercises From HtDP
    Date: 2025-01-07T13:21:18
    Tags: Learning, SoftwareEngineering, HtDP

Working through How To Design Programs; here's my first crack at one of the first exercises!

<!-- more -->

So there are a few of us in the newly started [Detroit Tech Watch](https://detroittechwatch.com) book club and we're reading (and working through) [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html).  I just wanted to share my first crack at one of the exercises in the book's prologue.

```racket
; constants
(define WIDTH 200)
(define HEIGHT 400)
(define ROCKET . )  ; Rocket is an image which you can see on the HtDP site
(define UFO (overlay (circle 10 'solid 'green)
                     (rectangle 40 4 'solid 'green)))

(define HEIGHT-OF-ROCK-BED 10)
(define ROCKET-CENTER-TO-TOP
  (- (- HEIGHT HEIGHT-OF-ROCK-BED) (/ (image-height ROCKET) 2)))

(define UFO-CENTER-TO-TOP
  (- (- HEIGHT HEIGHT-OF-ROCK-BED) (/ (image-height UFO) 2)))

(define ROCK-BED (rectangle WIDTH HEIGHT-OF-ROCK-BED 'solid 'grey))
(define BASE-SCENE (empty-scene WIDTH HEIGHT 'blue))
(define SCENE (overlay/align 'right 'bottom ROCK-BED BASE-SCENE))

; functions
(define (picture-of-rocket.v4 h)
  (cond
    [(<= h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET (/ WIDTH 2) h SCENE)]

    [(> h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET (/ WIDTH 2) ROCKET-CENTER-TO-TOP
                  SCENE)]
    ))

(define (picture-of-ufo h)
    (cond
    [(<= h UFO-CENTER-TO-TOP)
     (place-image UFO (/ WIDTH 2) h SCENE)]

    [(> h UFO-CENTER-TO-TOP)
     (place-image UFO (/ WIDTH 2) ROCKET-CENTER-TO-TOP
                  SCENE)]
    ))
```

Since they don't call out `overlay/align` in the text I feel that I must have missed something.  However this seems to accomplish what they are looking for (as best I can tell).