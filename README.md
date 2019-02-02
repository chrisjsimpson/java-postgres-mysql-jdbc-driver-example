# Setup 

1. Need to download the mysql java JDBC connector if not got already:
     https://dev.mysql.com/downloads/connector/j/ 
2. Then add the java JDBC connector to the class path e.g. :
     
     export CLASSPATH=/usr/share/java/mysql-connector-java-8.0.15.jar:$CLASSPATH
     # Or copy /mysql-connector-java to current directory
     export CLASSPATH=./mysql-connector-java-8.0.15.jar:$CLASSPATH 

     # Set user and password
     export DB_USER=root
     export DB_PASS=password

# Then you can run:

     javac Mysql.java
     java Mysql
