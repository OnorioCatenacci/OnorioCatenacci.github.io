    Title: Debugging Rust On Windows
    Date: 2025-04-02T15:08:52
    Tags: DRAFT, Rust, SoftwareEngineering

In order to help with the work of porting Zed to Windows, I've been trying to get Rust debugging going on Windows. It's been an exercise in Yak Shaving mainly due to me.

<!-- more -->

So, as I've told some friends, I have been trying to improve Zed on Windows. I started playing with creating regression tests [ZARTS](https://codeberg.org/OldDutchCap/zarts) although it's so early it's hardly worth speaking of. And one thing I spotted is that some of what I'd consider standard behavior on a Windows app isn't there just yet. For instance, unless MS has decided to forego CUA standards, F10 should open the menu for you. Some may not care about this but if you are a touch typist having to take your hand off the keyboard to get the mouse can break your flow.

At any rate, I'm getting close to figuring out how to add F10 -> menu to Zed but as I was working on it I discovered that debugging rust apps is a bit of a tricky proposition. Further while a developer can use either GDB or LLDB on *nix or Macs, the story for GDB on native windows isn't good. So it's pretty much LLDB. *I say native windows because GDB may work fine on WSL. I don't know and haven't had inclination to try it.*

Getting LLDB to build on my Windows box is a bit of a trick.
