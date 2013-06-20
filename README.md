Mime
====

Mime is a tool for Ops folk that allows you to record your troubleshooting for macros and documentation

Requires
--------

* gem github-markdown

Description
-----------

I don't know how many times I've been working on troubleshooting something just to have to trace back through my bash history to remember how I went about doing it. Not only that, but after I had fixed something I found myself going back through and automating it based on the same steps I had just done. That seems fairly repetative, and I wanted to find a way to fix this issue. Enter Mime.

Mime is a tool that will allow you to record your actions in the shell, and will document them neatly in a format such as markdown. SOPs and Documentation will be greatly simplified.

The second feature of Mime is acting as a Macro engine to repeat whatever steps you've taken to troubleshoot an issue, and using testing frameworks validate that it succesfully diagnosed and cured the problem. It can be the base to a self-healing and autonomous network.

The real fun starts when you start adding dynamic content to the macros, allowing for mime to grow and learn new methods of troubleshooting that may be more effective.

Macros?
-------

...but wait, these aren't macros! They don't expand into more code! You'd be right in saying that, and that is true at this point but you have to be able to walk before you can start sprinting. Macros themselves and code expansion are planned for this, but a lot of testing has to be done to make sure it works properly. 

The more powerful a tool, the simpler it becomes to make some nasty side-effects.

How do I plan to achieve this? Using interpolation methods and shorthand code, we can expand these into a lot more elegant and powerful solutions. By using this and chaining mime scripts together some really powerful tools can be made extremely quickly.

Now if this sounds an awful lot like LISP, it really is. That's primarily because I want to see if I can do some of this in Ruby before I redo most of the code in either Clojure or Common Lisp to really play with some macro functionality.

Nifty Trick
-----------

Put this into a mime file
    
    sed 's/^#!.*//' < mime.rb > mime.mime; ./mime.rb document mime

...and then open doc-mime.html. You'll have made Mime just document itself. Meta miming perhaps?

Recording
---------

To record, simply type 
    
    ./mime.rb record (macro-name) 
    
...to start recording, and stop to stop. Commenting your code can be done by using # at the beginning of the line.

Running
-------

Running a macro will execute all lines not starting with #, as
    
    ./mime.rb run (macro-name)

Documentation
-------------

By starting a line with #, it will be interpreted as a comment. Comments can be written in Markdown and exported into an HTML page, as
    
    ./mime.rb document (macro-name)

Plans
-----

Commands:

    ./mime.rb record (macro-name)
    ./mime.rb document (macro-name)
    ./mime.rb run (macro-name)
    ./mime.rb merge (macro-names)
    ./mime.rb delete (macro-name)

Planned Features
* Markdown support for Documentation [DONE]
* Dynamic commands
* TCL Integration for Mime'ing SSH and Telnet sessions, or some other method

Commentary and Notes
--------------------

A clever thing you can do, if you so wish, is have mime macros call eachother in tandem. This can yield some really interesting results in some cases, as well as making this an increasingly ad-hoc reinvention of LISP.

I'm going to do the first round through in Ruby to get a basic working app up, and as I get more comfortable with Clojure I may well start porting it over as an experiment with both it and LISP Macros. Looks like I'll be reading through Let Over Lambda all the way through for this one.

Eventually I would very much like to integrate a more full bodied AI into this so Mime will learn what the fastest way is to recognize and fix issues. Mime will learn the basics from you, and then go about its merry way doing some crazy stuff. To be fair this DOES have the possibility of going horribly awry, but that's why we're not using it in production, right? We are? Perhaps I should finish a EULA....
