## Design Questions

**What is your definition of an object?**

By standard definition, an object is anything that possesses state and behaviour. In our definitions, our objects (that we deem sortable) are things with key definining attributes, onto which sort applications can be applied.

**What strategies should be deployed in terms of accepting input (i.e. the large number of objects.)?**

We can accept input for source in two key ways: first, users can enter directly into the command line. Second, users are able to enter data in the form of text file input. In this form, the user is requested to input a file, and a text file path is input into the program. Then, the sort operations will sort with regards to the text file input.

**Is your sort generic? What sorting criterion does your system use? Is this criterion flexible; i.e. changeable by the user at the point of execution? What limitations have you placed upon legal sorting criteria? To make it reusable to other people, how should we include it into the Ruby Class hierarchy?**

We can make this sort generic in the following manner: users can either enter in objects which contain established classes (examples are numbers, strings) which have predefined sort functions. The second manner that users can enter data in is hash maps - where the relevant key must be in a standard comparable class. Then, the sort operations are carried with respect to the key.

You can include the upgraded class as a descendant of the Comparable class, wherein the def <=> is written exclusively for the data construct provided.

**Describe “equationally” what is happening to your solution as you increase the concurrency (e.g. produce a regression model (remember regression from Statistics) of processing time against the number of threads.**

In reality we have a uniprocessor system, Your solution can be modeled as a program which: (1) has a component which produces threads; and (2) a set of threads which undertake the same (small) task. This is in essence the basis of stress testing. 

We can describe our solution equationally as such:

-----

/// INCLUDE EQUATION HERE

-----

Given this, we provide the regression model as such:

-----

/// INCLUDE REGRESSION MODEL HERE

-----

**Concurrent systems tend to crash frequently – what approach to exception handling have you devised? Consider the content of the library at: [http://c2.com/cgi/wiki?ExceptionPatterns](http://c2.com/cgi/wiki?ExceptionPatterns); which are applicable to this problem? Is Module Errno useful in this problem? What components of the Ruby exception hierarchy are applicable to this problem? Discuss in detail your strategy for exception-handling.**

We can implement a threadDeath system, in which failures in one of the threads in the system can be sent back to the parent process. If the parent process identifies an early termination (whether by termination as a result of a failure to process, or an external failure) then the system can terminate the sort early and preserve teh data.

Other exception handling techniques we have devised are as follows:

-----

/// INCLUDE EXCEPTION HANDLING TECHNIQUES HERE

-----

As for the references above, we have chosen to integrate the following:

-----

/// INCLUDE INTEGRATED EXCEPTION PATTERNS HERE

-----

**What differences exist between thread-based and process-based solutions? How has this impacted the design of your solution?**

Fundamentally, process-based solutions handle everything in the same process. That is, everything is encapsulated in a single systen. This means that  the loading, the processing, the output are all combined together. This leads to an enclosed system, which is very easy to test and ensure its robustness - however, it leads to bad design, as it is quite easy to load multiple roles onto the same process. Additionally, process-based solutions need all data stored together, which can lead to different design decisions.

In contrast, thread-based solutions can load different threads with portions of the data presented, and process them separately. This means that each thread knowingly only has a smaller subset of data, not the whole set. This comes with its advantages and disadvantages: while it may be a more efficient manner of handling data, it is often easier to break, and is difficult to test (compared to process-based solution).

In our design, we must account for these facts, and develop our thread solutions to only handle the problem for its specific role. This means we must keep in mind the advantages and disadvantages of thread-based solutions presented to us, and ensure that we shore up our disadvantages while working towards our advantages.

**Do you have any race-condition or task synchronization concerns about your solution? How do we tidy-up a multi-threaded program, if stopped midexecution?**

Sample sort eliminates race-conditions that could occur. By setting it in stages, the sort has to wait until its systems had synchronised - resulting in zero potential for any race condition. However, we do need to ensure that task synchronisation has occured. We can use this by setting a status variable that tells us the current status - alternatively, we can use interrupts to circumvent this issue.

In order to tidy up a multithreaded program, we must send kill signals to the thread in order to clean up properly. We can set special 'kill' events that occur once the thread has been killed - in which case the thread will dump all data it holds, ensure that it's allocated space has been cleared, and terminate.

**As discussed in CMPUT 301: What is configuration management? What is version control? Are you using either concept? If “yes”, describe your process and any tool support what you utilize – illustrate your process with regard to Assignments 1 and 2; if “no”, justify your decision.**

Configuration management is a process implemented to facilitate system changes. Much like a Management of Change process, its goal is to ensure the integrity of a system is preserved over a period of time. 

Version control is one way to ensure configuration management. Version control builds the system by 'versions', preserving previous iterations of the code build as development is made. By doing so, one can revert to previous versions of the source code if errors were to arise.

We are using multiple tools to help with configuration management and version control. Generally, to facilitate both management of change and version control, we use technologies such as Git. Additionally, with regards to the 'soft' portion of configuration management, we use Google Hangouts as well as other networking tools in order to ensure a digital reference to our works. We also perform meetings in order to have a face-to-face discussion period.

We have used these technologies in previous assignments as well. In assignments 1 and 2, Github was used extensively to facilitate version control. We created branches to build functionalities, and merged once the team was made aware of the changes. One example of this was building the 'cd' system in Assignment 2 - the functionality was built in a branch, and the results merged and integrated with the system once tested and discussed.

**What is refactoring (as discussed in ECE 325 / CMPUT 301)?**

Refactoring is the process of optimising code without changing behaviour.

**Are you using refactoring in your development process? Justify your answer. If “yes”, give examples, minimum of 2, of the refactoring “patterns” that you used in Assignment 1. If “no”, give examples of where your solution to Assignment 1 would be improved by applying refactoring patterns. Supply a minimum of two different (i.e. different refactoring patterns) as examples.**

We are using refactoring, and have been in our previous two assignments. In Assignment 1, two refactoring patterns that we used are:

1. Extract method: we used this to solve the issue of Shotgun Surgery. This saved us from making many minor changes separately, and simply edit one file to handle all changes. One example of implementing this is extracting the decompose() function - we made sure that the process was encapsulated in one function, and simply called it if needed.
2. Extract class: we applied this to our module. Instead of creating one large module that held all of our library, we separated them based on what we needed - creating modules such as Operations, Properties, ... etc.

## Design
### Rationale:
http://parallelcomp.uw.hu/ch09lev1sec5.html

### Input
Data is read from a file, each number is on a new line or comma separated (ONLY ONE!)
Data is input from command line
File is sanitised

### Parsing
Data is sanitised before input
Data is checked for validity

### Processing
Data is split into sections, each section is sent into threads
Each thread puts their data (according to sample sort) into a bucket
Each bucket sorts
Buckets are compiled and sorted

### Return
Data is printed into file, output file data ensured validity

### ECE 422
Maybe watchdog/timer integration?
Maybe adjudicator integration? <- probably not given size