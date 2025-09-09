    Title: Modeling And Software Development
    Date: 2025-09-09T09:25:08
    Tags: SoftwareEngineering, Opinion

A brief discussion of some obvious observations that are routinely forgotten. We're dealing with models and we're not all dealing with the same models.

<!-- more -->

One thing that strikes me again and again as I mull the profession of software developer is how often we forget fundamental truths about what it is we're doing.  I hope you'll indulge me for a few paragraphs while I lay out some thoughts on what seems so obvious that it's usually forgotten.

## Models, Abstractions And Reality

First, although all of us should have this quite firmly in our heads by now, it's wise to remember that models are simplifications of reality.  Reality is messy and doesn't want to conform to your neatly built mental constructs.  Reality is that the ratio of the circumference of a circle to the diameter is 3.14159265358. The model is that it's ∏ (Pi). _Lest anyone start splitting hairs with me, yes I know that pi is actually more real than any decimal. I'm just trying to make a point about the messiness of reality versus the clean, discrete nature of models._ Reality is that the atomic weight of aluminum is 26.9815385. (I can recall how mind boggling I found it when I first learned that atomic weight wasn't an integer.) The model is that it's 27.  And so forth and so on ad infitum.

And so we must be quite careful to remember that any software artifact we're dealing with involves at least two models (and very likely three) and at least one bit of reality. For any software artifact there's the model of the person(s) requesting that the software be built.  There's the model of the software developers building the software.  And likely there's the model of the actual software which is unlikely to correspond _exactly_ to either of the other two models.

What does this mean in practicality?  A few conclusions jump out very quickly.

**The person requesting the software is already abstracting the reality of what they want.** As human beings often do, they are likely to omit details because "well that's so obvious I don't need to say it!"

**The process of communicating the mental model of the person requesting the software to the software developer is error-prone and often fragile.**  There are a few good reasons for this:

a.) It's not usually a direct communication.

b.) Even in cases where there is direct communication it's done in natural language which is inherently (intentionally) ambiguous.

c.) The mental model of the person requesting the software to be built is often incomplete and lacking details.

**The software artifact that is created presents its own model of the situation.**  This model doesn't have to correspond to either the model of the person requesting the software to be built or the model of the software developers building the software. You may read that last sentence and say "Waitasec!  How could it not represent the mental model of the people building the software?"  A couple of things are in play here:

a.) The developers may not know how to express their mental model in code.  Developer skills vary along a spectrum of "fresh out of a coding bootcamp" to "years and years of experience." Even with years and years of experience there's no guarantees that the developer will be able to express his/her model of the code in the code.

b.) There's a translation between the source code and the actual instructions which the computer executes.  This is not a trivial step.  Almost every language of which I am aware allows for certain things to be "implementation details".  Consider this: in C# what size is an "int"?  If you said 64 bit, you're wrong.  It would seem to make sense that on a 64-bit machine it'd be 64-bits but it isn't.  I recall once when I was starting as a software developer that we ran into a very odd bug.  Hard to reproduce.  I'm embarassed to say I was ever this green but I was--the issue was that we didn't specify the return type of a C function.  The function should have returned a double.  Because we didn't specify the return type (you don't have to in C) the compiler was silently truncating the double to an int (C's default return type).  There are other examples I could give but I trust the point is made.

**Models expressed in natural language are inherently hard to check for contradictions and inconsistencies.**  If a business says that at some point an invoice should be marked "pending" and at another point it should be marked "resolved" are those two states mutually exclusive?  They don't have to be.  Unless and until someone asks "hey can an invoice be pending and resolved?" that inconsistency is there.  This is one of my issues with models that rely on boxes and arrows.  Don't get me wrong--they're great communication tools and communication is exceedingly important.  But in many cases they cannot easily be checked for contradictions or inconsistencies.

So pretty much all of the preceeding discussion should strike experienced developers as "Well congratulations Captain Obvious! You've managed to state what everyone knows!"  But my issue with "everyone knows that" is how often "everyone" forgets it. These are the rules of the game we play and we don't often spend time considering the implication of these rules and what steps we can take to be more effective in what we do.
