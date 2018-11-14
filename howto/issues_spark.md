# Issues and causes for later reference in the spark runs.

1. The file path was local but spark thought its hdfs.
   Always use `file:///<path>` for local files to be explicit.
   ```
   18/10/04 16:11:35 INFO SharedState: Warehouse path is 'file:/home/jenkins/csv_check/spark-warehouse/'.
   18/10/04 16:11:36 WARN DataSource: Error while looking for metadata directory.
   Exception in thread "main" java.net.ConnectException: Call From micron4u-ubuntu/192.168.0.63 to micron4u-ubuntu:8020 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused
   at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
   at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
   at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
   at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
   ```

