# Concurrency Coupling
    [Producer] --> [Buffer/Relay] --> [Consumer]



## Robust Design = Concurrent 
    Management                []
    |                         /\
    |                       []  []
    |                       /\  /\
    V                      [][][][]
    Worker

```ruby
def waitfor(filename) 
  loop do
    if File.exists? filename 
      processor = Thread.new do
        process(filename) 
      end
      Thread.exit 
    else
      sleep 60
    end
  end
end

t1 = Thread.new{waitfor(firstfile)}
t2 = Thread.new{waitfor(secondfile)}
```

# Thread group
Implements task clustering
```ruby
group = ThreadGroup.new
group.add a
group.add b
```

# Synchronized Queues
  * Class Queue and SizedQueue are thread aware queues allowing the safe buffering of information
  * Implements Buffer and relay task ideas.

```ruby
Buffer = SizedQueue.new(50)

Producer = Thread.new do
  loop do
    #Produce item
    buffer.enq item
  end
end

Consumer = Thread.new do
  loop do
    item2 = buffer.deq
    #Consume Item
  end
end
```

# Semaphores
  * Standard O.S. semaphores via Mutex
  * Need to be global
  * Dont nest => Deadlock

```ruby
require “thread” 
$semaphore = Mutex.new

def shared_function(some_thread_id) 
#....
  $semaphore.lock
    .... Do some processing normally 
    .... Involving a write
  $semaphore.unlock
end

t1 = Thread.new(Thread.current)
  { |param| shared_function(param) }
t2 = Thread.new(Thread.current)
  { |param| shared_function(param) }
t1.join 
t2.join
```

#Higher Level == Condition Variables
  * Solves a thead blocking in a sem lock
  * often requires the thread to enter the block protected by the semaphore

# Co-ordination Example

```ruby
require "thread"

$control = Mutex.new
$pc = ConditionVariable.new
$sc = ConditionVariable.new

$printers = 2
$scanner = 1

$control.synchronize do
    
    # obtain a lock; execute the block;
    # release the lock

  $pc.wait($control) while printers == 0
    # wait until printer is available
    # meanwhile release semaphore
  $printers = $printers - 1
    # safe because of semaphore
  $sc.wait($control) while scanners == 0
  $scanners = $scanners - 1
end
# complete actionl return resources
$control.synchronize do
  $printers = $printers + 1
  # give back to printer
  $pc.signal if printers == 1
  # unblock someone waiting
  $scanners = $scanners + 1
  $sc.signal if $scanners == 1
end
```

# Monitors
  * Encode the previous example into a single mechanism

#      
    Monitor Start
      function
        manipulate Condition Variable
      function  
        manipulate Condition Variable
    End Monitor

  * Can be nested
  * Slightly unusual appearance in Ruby    

```ruby
require "monitor"
Class Queue
  def initialize
    @que = []
    @monitor = Monitor.new
    @empty = @monitor.new_cond
  end
end

def enq(obj) 
  @monitor.synchronize do
    @que.push(obj)
    @empty.signal end
  end

def deq
  @monitor.synchronize do
    while @que.empty?
      @empty.wait
    end
    return @que.shift
  end
end
```

```ruby
require "monitor"

Class SizedQueue < Queue

def initialize(sz)
  super()
  @max = sz
  @full = @monitor.new_cond
end

def enq(obj)
  @monitor.synchronize do
    while que.length >= @max
      @full.wait
    end
    super(obj) #...
  end
end

def deq
  @monitor.synchronize do
    obj = super()
    if @que.length < @max
      @full.signal
    return obj #...
  end
end
```

# Problem: Delete a directory

```ruby
def delete_all(dir)
  threads = []
  Dir.foreach(dir) do |e|
    # skip the operation for . and ..
    next if ['.','..'].include? e
    fullname = dir + File::Seperator + e
    if FileTest::directory?(fullname)
      threads << Thread.new(fullname) do |fn|
        delete_all(fn)
      end
    else
      File.delete(fullname)
    end
  end

  threads.each { |t| t.join }
  Dir.delete(dir)
end

# the call
Delete_all("/tmp/stuff")
```


