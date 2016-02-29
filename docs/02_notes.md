# Thread-Based Programming

```ruby
thread = Thread.new do
  #Statements
end
```
```ruby
thread = Thread.new(a,b,c) do |d,e,f|
```
## Return Values from a Thread
```ruby
thread = Thread.new do
  t = Thread.current
  t[:var1] = "string"
  t[:var2] = 365
end

x = thread.var1 #=> string
```

## Achieving a Rendezvous

```ruby
t1  = Thread.new do 
  somthing_long() end
something_short()
t1.join
#Main thread waits for t1.
```
### Returnign Values Cleaner Soln
```ruby
thr = Thread.new do 
  sum = 0;
  return(sum); end
guess = rand(1000)
if guess == thr.value puts "right" else uts "wrong"
#value -> a join + retrieve return value
```
## Scheduling
```ruby
#Highest priority first
threadname.priority = 3

#Gives up CPU
threadname.pass 

threadname.stop

threadname.sleep

threadname.wakeup

Thread.abort_on_exception = false
Fact100 = Thread.new do 
  begin 
    #stuff
  end

if fact100.alive? 
  fact100.raise()
end
```

Main- Kill/Birth
Use a poll Thread to manage all other threads in case main gets killed.

    Main(Kill/Birth) - High Priority

    Poller(Polling) - Med Priority

    T1, T2(Workers) - Low Priority

