# How to get a stack trace for each thread in a running python script

Sometimes a python script will simply hang forever with no indication of where things went wrong. Perhaps it's polling a service that will never return a value that allows the program to move forward. Here's a way to see where the program is currently stuck.

## Install gdb and pyrasite

Install gdb.

```sh
# Redhat, CentOS, etc
$ yum install gdb

# Ubuntu, Debian, etc
$ apt-get update && apt-get install gdb
```

Install pyrasite.

```sh
$ pip install pyrasite
```

## Inspect process with pyrasite

Find the process ID for the stuck python process and run `pyrasite-shell` with it.

```sh
# Assuming process ID is 12345
$ pyrasite-shell 12345
```

You should now see a python REPL. Run the following in the REPL to see stack traces for all threads.

```python
import sys, traceback
for thread_id, frame in sys._current_frames().items():
    print 'Stack for thread {}'.format(thread_id)
    traceback.print_stack(frame)
    print ''
```

# Source
https://gist.github.com/reywood/e221c4061bbf2eccea885c9b2e4ef496

