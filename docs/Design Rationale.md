### Rationale:
http://parallelcomp.uw.hu/ch09lev1sec5.html

Plan on making a sample sort for the application.

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