## Need a a quick way to get runtime of functions
  By using a decorator its just a oneline change. python2.7 
  may or may not have the required utilities but I have been
  using this in my code while debugging.

#### The function definition:
  ```python
    import time
    def timeit(method):
        def timed(*args, **kw):
            ts = time.time()
            result = method(*args, **kw)
            te = time.time()
            if 'log_time' in kw:
                name = kw.get('log_name', method.__name__.upper())
                kw['log_time'][name] = int((te - ts) * 1000)
            else:
                print '%r  %2.2f ms' % \
                      (method.__name__, (te - ts) * 1000)
            return result
        return timed
  ```

#### Usage:
  ```python
    @timeit
    def myfunc(...):
			...
  ```

  Output:
  ```bash
   <stdout of myfunc()>
   ...
  'myfunc' XXX.XXX ms
  ``` 
