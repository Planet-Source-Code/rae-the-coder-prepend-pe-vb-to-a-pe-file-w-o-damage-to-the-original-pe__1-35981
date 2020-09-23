Prepend a PE file using VB - by rae
-----------------------------------------
I tried looking for such source code online and couldnt find any except in x86asm
so here it is for vb users.....

In order for this to work, compile the project in dir ./prepend a vb app/example/ and copy 
the example.exe to the root dir ./prepend a vb app/example.exe .  After this open up 
prepend,vbp and compile to the same folder.  Run prepend.exe and watch vb work its magic.


I made this project after reading a paper about asm.  they were talking about how programers
were amazzed to find out that a program will still run even when appended by another.
then they took it to the next step, prepending an still getting it to work.  then an
even greater step, filling the programs white space up with code and running the program
+ the code that filled the white space without any errors.

i got it to work in asm and wondered if there was any way to get any kind of prepend, append, 
or white space fill effect in a vb writen app.  all i got was the prepend.  append only
worked if i knew what compiler made the program (masm hehehe, not vb6 or vc++...sorry lads).
white space i wasnt even gonna try, youd have to get the len() of all the white spaces, then
put a marker in front of it such as 

before white space

[exe header]
[whitespace]
[code blah]
[whitespace]
[code blah]
[application info.]
[whitespace]
[more white space...]
[..................]
after

[modified exe header]
[1 code to run here]
[code blah]
[3 code to run here]
[code blah]
[application info.]
[2 code to run here]
[5 code to run here]
[4 code to run here]

just number them in the order that the go in.  such that when the exe is executed,
it would go: ok i need to put this code inorder then print out to a file, thus it would go

-ok found 1, writing....
-ok found 3, storing in memory
-ok found 2, writing
-ok found 5, storing in memory
-ok found 4, storing in memory
-ok found no more
-ok dump memory and write #3-#5
execute writen file, execute the original file after replacing code #1-#5.


heres what i did tho:
(where .... , ....=whitespace

before

[exe header]
[code]
[code]
[....]
[info]
[....]

after

[prepender exe header]
[code]
[code]
[....]
[info]
[....]
[....]
[TAG HERE TO FIND START OF OLD EXE]
[exe header]
[code]
[code]
[....]
[info]
[....]
[....]
[....]
[....]
[....]


(extra [....] to simulate added white space)