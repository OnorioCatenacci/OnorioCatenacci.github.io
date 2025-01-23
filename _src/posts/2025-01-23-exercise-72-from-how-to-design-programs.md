    Title: Exercise 72 From How To Design Programs
    Date: 2025-01-23T14:09:01
    Tags: Learning, SoftwareEngineering, HtDP

My response for Exercise 72 (Chapter 5.6) of [_How to Design Programs_](https://htdp.org/2024-11-6/Book/index.html)

<!-- more -->

```racket
#lang typed/racket

(struct phone-number ([area : String] [switch : String] [num : String]))
(struct entry ([name : String] [phone : phone-number] [email : String]))
```

I'm using Typed Racket here rather than BSL because unless I need to do some graphic work I don't see any reason to solve the problems in BSL since that's ultimately a dead end.
