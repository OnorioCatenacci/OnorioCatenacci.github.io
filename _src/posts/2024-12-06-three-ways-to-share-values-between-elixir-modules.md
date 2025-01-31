    Title: Three Ways To Share Values Between Elixir Modules
    Date: 2024-12-18T09:40:00
    Tags: Elixir, CodingRecipes

A recipe for avoiding repeated definitions in [Elixir](https://elixir-lang.org) modules!
<!-- more -->
I find that as I get older I find myself trying to remember coding techniques and idioms that shouldn't be hard to remember but sometimes are anyway.  This is one of those cases--the module attributes took me a bit of effort to work out so I thought I'd write it down.  I'm sharing it here so others might benefit from it as well.  

## What Do I Mean By Constant?

First it feels appropriate to say that when I say constant I have a definite technical meaning in mind.  In a mathematical sense a constant like **pi** or **e** is simply a value that's fixed on the number line.  In the sense that software developers use the word "constant" we usually mean something which is an extension of the notion of a mathematical constant--a fixed value.  It could be a number or a string or even a more complex data structure; the point is that in the course of the normal execution of the binary it won't change.

Here I'm using the term constant to name a value that needs to be referenced in two or more modules in Elixir which none of them will change.  The value will be defined in one module and then read from others. There are two reasons to do this approach: 

1. It makes the code more readable
2. It keeps the developer from repeating his/her self.  

Both of those are good reasons for using this approach.  I'm going to examine them a little bit before I discuss the coding techniques specifically.  

## More Readable Code

While a compiler and/or interpreter doesn't care about the difference between code using literals and code using symbolic names, developers very much care about this.  If I have code that reads like this:

```elixir
def is_odd_number?(number), do: rem(number,2) != 0 # Version 1
```

vs.

```elixir
def f(n), do: !(rem(n,2) == 0)                   # Version 2
```

which one conveys the intent of the coder better?  Now you might say "Hey no one names their functions _f_ and no one names their arguments _n_" and I wish I could say you're correct.  But I have run across code like this in practice and it's hard to decipher--well for a human being to decipher at any rate.  The compiler doesn't care either way. The point is that using descriptive names (as opposed to bare literals) is a great technique for making your code more readable.  
Constants, in this sense, are a form of a descriptive name for a quantity. 

You may even have to read your own code in six months and you'll be glad you took the extra time to make it easier to understand.


## Keeps the Developer From Repeating

It's become a mantra chanted over and over by developers who don't know much but they do know that repeating _anything_ in code is a bad idea.  Except it isn't always a bad idea. The trick is to know when it's ok to repeat things and when it isn't.

Part of distinguishing between one case and the other is to understand why repetition is a bad thing in the first place.  The problem is that if I duplicate code and said code needs to be fixed later there's a good chance I won't find all the duplications and fix them too.  And that's assuming I'm working on my own code.  It's even more likely to be a problem when someone else will be maintaining your code. They're more likely to miss spots where the code needs to be fixed. 

So the next time you're tempted to copy/paste a bit of code think of your future self (or perhaps the poor person who will maintain your code) and do a bit of refactoring so you don't need to repeat the code.

Now, there are times when repeating code actually simplifies things.  Part of the issue with removing duplication is that it introduces coupling.  As long as your coupling is clean and simple (in the decomplected sense of "simple") you're fine. Shared definitions--numerical constants, strings that signify names, etc.--definitely fall under this rubric.  
 
However code under maintenance tends to get a lot of "this is almost what I need but not exactly".  This is part of the reason people tend to copy/paste code in the first place.  So the admonition to avoid repeating code is not an absolute one and you should apply your judgment.  Is the place where you're thinking of copy/pasting likely to change frequently?  Are the changes likely to differ from changes to the original code?  Then by all means copy/paste. On the other hand, if it's not likely to change frequently then you're better off to reference the single definition from the other places in your code.  An example of something which may change but is not likely to change often is a company name.  It's possible for a company to change its name but it's not likely to happen very frequently.  If you've hard-coded that name 50 places in your code that's 50 places you have to find and fix.  If you hard code it in one place and then reference the constant in other code then you only need to fix it in one place.

Partially the decision about what should be repeated and what shouldn't comes down to cohesion; that is to say, how much does the code in some particular block of code all serve one function.  If a piece of code is highly cohesive (e. g. a function to calculate the area of a circle) vs a lower cohesion function (e. g. calculate the area of a circle, print the circle in three colors and then return the current date) then it's better not to repeat the code.  Our judgment about copying and pasting code should be inversely proportional to the strength of the cohesion of the code. 

Like many ideas in engineering the notion of "don't repeat yourself" is not one that can be applied without thought or judgment.

## Constants In Elixir

Now having said all that let's talk about a couple of ways to deal with values shared between modules in Elixir.  You can register an attribute in one module and then reference that attribute from the other modules or you can create a (for lack of a better name) constant function--that is a function that takes no argument and simply hands back a constant value.  If someone knows the right name for this sort of function please post it in the comments for me! For sake of illustration I'll pretend I need a Pi constant in my code.

Consider the following code:

```elixir
defmodule MyMath do
   Module.register_attribute(__MODULE__, :pi, persist: true)
   @pi 3.141592653

   def pi, do: 3.141592653
   # this could also be: 
   # def pi, do: @pi
end
```

and now there are two ways for me to fetch the value of Pi in other modules:

```elixir
defmodule My.Other.Module.That.Needs.To.Know.Pi do
   defp get_pi do # module attribute approach
      [pi] = MyMath.__info__(:attributes)[:pi]
      pi
   end

   def circle_area(radius) do
      MyMath.pi() * radius * radius #constant function approach
   end

   # or
   def circle_area_alternate(radius) do
      get_pi() * radius * radius
   end
end
```

Both of these approaches will work.  The attributes approach is really not recommended for a constant shared between modules.  It's more recommended for metadata about a module--author, last revision date etc.  The more recommended way to do this (although I will grant that it looks a bit odd) is a constant function. 

Finally, here's the third way to share values between modules. I wish I could take credit for coming up with it but as far as I know that credit belongs to Paul Schoenfelder (aka BitWalker) who's a super-smart developer! 

The trick is to define the value to be shared in a using macro in the source module.  Like this:

```elixir
defmodule MyMath do
 defmacro __using__(_) do
    quote do
       @pi 3.141592653
    end
end
```

Then you can simply use the module in a different module and the using macro is run and the value becomes available. Like so:

```elixir
defmodule My.Other.Module.That.Needs.To.Know.Pi do
   use MyMath

   def circle_area(radius) do
      @pi * radius * radius #"using" macro approach
   end
end
```
The main idea here is that if you're using the same named value in multiple modules, you want to avoid _defining_ it more than once.  Defining the value in several different modules is an excellent way to insure that someone will miss changing the value somewhere in maintenance and that can lead to some really odd, difficult to reproduce bugs.

