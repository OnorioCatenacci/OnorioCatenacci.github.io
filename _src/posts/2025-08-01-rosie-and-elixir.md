    Title: Rosie And Elixir
    Date: 2025-08-01T11:58:31
    Tags: Pattern Matching, Elixir, Searching Code

I've been working on writing [PEG](https://en.wikipedia.org/wiki/Parsing_expression_grammar) expressions with [Rosie Pattern Language](https://gitlab.com/rosie-pattern-language/rosie) to help people to search Elixir code bases for certain things.  Very preliminary but I did want to share what I've got so far.

<!-- more -->

A few years ago I gave a talk at the Elixir Conference about searching code.  One of the last techniques I covered was using Dr. Jamie Jenning's excellent Rosie Pattern Language. I think of Rosie's implementation of parsing expression grammars as a large step forward from writing regular expressions.  Dr. Jennings has added lots of nice features to enable writing and testing PEG's.  I'm currently thinking of using Rosie as a means of prototyping PEG experessions and then implementing them in -- oh maybe Rust or Racket.  Best of both worlds--get the speed of a systems language and the ease of use of Rosie to build/test my expressions. 

So I've been slowly building up a file of patterns for Elixir.  Here's the code as it stands right now:

```
-- 
-- Elixir Patterns
--
-- This file contains Rosie Pattern Language (RPL) patterns that can be used to match Elixir language constructs.

-- 
-- LICENSE: MIT License (https://opensource.org/licenses/mit-license.html)
-- AUTHOR: Onorio Catenacci
-- 11 July 2025

rpl 1.3
package elixir

grammar
   comment_char = "#"
   string_interpolation = "#{"
   comment_text = .+ 
in
   comment = {comment_char & ! string_interpolation ~ comment_text} 
end

-- test comment accepts "# this is my test"
-- test comment accepts "#Jammed right up against the octothorpe"
-- test comment accepts "## this is a style of comment I've seen before"
-- test comment rejects "def myfunc()" 
-- test comment rejects "string = This is my #{string}"
-- string on next test is borrowed from Elixir standard lib
-- test comment rejects "Access.filter/1 expected a list, got: #{inspect(data)}" 


grammar
   attribute_char = "@"
   attribute_name = {[[:alnum:][_.]]}+
   mdoc = attribute_char "moduledoc"
   doc = attribute_char "doc"
   type = attribute_char "type"
   callback = attribute_char "callback"
   specifier = attribute_char "spec"
in
   attribute = {mdoc / doc / type / callback / specifier} / {attribute_char ~ attribute_name}
end
-- test attribute accepts "@doc"
-- test attribute accepts "@moduledoc"
-- test attribute accepts "@tag_test"
-- test attribute rejects "@tag test" -- no spaces allowed!

variable = {[[:alnum:] [_.]]}+
grammar 
   standard_sigils = {"~r"/ci:"~s"/"~c"/"~w"/"~D"/"~U"/"~T"/"~N"}
   custom_sigils = {"~"[:alnum:]+}
in 
   sigil = {standard_sigils / custom_sigils}
end

atom = {!{comment/attribute/sigil} & {":"/[:upper:]+} variable*}
-- test atom accepts "Atom"
-- test atom accepts ":Erlang"
-- test atom accepts ":erlang"
-- test atom rejects "erlang"
-- test atom rejects "1Erlang"
-- test atom rejects "# This is a test atom"
-- test atom rejects "# :erlang"
-- test atom rejects "@tag"
-- test atom rejects "@Tag"
-- test atom rejects "~S\"\"\""

grammar
   dmodule = "defmodule"
   optional_start_delimiter = "do"
in
   module = {^dmodule ~ atom ~ {optional_start_delimiter}?}
end

-- test module accepts "defmodule A do"
-- test module accepts "defmodule A.B"
-- test module accepts "defmodule Zz do"
-- test module accepts "defmodule Z0_9 do"
-- test module rejects "defmodule _ do"
-- test module rejects "defmodule a do"
```

By the way all this stuff is in the [ex_rose repository](https://codeberg.org/OldDutchCap/ex_rose) if you'd care to look at it yourself or even contribute to it. 

Part of my thinking was beside the ability to use this to search files, it would also allow us to have PEG expressions for Elixir.  I believe some folks have started to try to build EBNF for Elixir and I think PEG expressions would also be helpful and make some sense. 

## What's That You're Saying?

So to explain the Rosie code above a bit.  The file starts with some documentation--the license, my name etc.  It also specifies the version of the Rosie Language Engine we're using. 

Next is the definition of a comment in Elixir.  While this is fairly straight-forward, there's one edge case I've found so far and I deal with it. That is, saying "#" followed by any string will accidentally treat string interpolation (#{) as a comment as well.  So I make sure I specifically treat that case as well. I may build out a doctest construct using my comment pattern but I haven't decided yet.

Next is one of my favorite things about Rosie.  Built-in unit tests.  As I'm working on creating patterns unit tests help me to ensure my refactorings don't accidentally regress anything.  Plus, as you may notice, when I find a case that doesn't work, I can add it as a test. 

## Ok, So How Can I Use This?

I've included a couple of quick shell scripts into the repository as well.  In the spirit of Unix utilities, they'll output matching text which can then be filtered further to find what you're looking for.  I have to admit I'm not 100% on the difference between rosie grep and rosie match but that's not really my main concern anyway.  

The usual stuff applies--if you think this is an interesting/worthwhile project please feel free to contribute.  If you've got a lot stronger grasp of correct Elixir syntax please feel free to let me know what I've gotten wrong.  