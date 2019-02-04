# Simple example connecting to Mysql and Postgres databases in Java

Uses Environment variables for the username and password. Useful
for container like environments.

# Setup 

1. Need to download the mysql java JDBC connector if not got already:
     https://dev.mysql.com/downloads/connector/j/ 
     https://jdbc.postgresql.org/download.html
2. Then add the java JDBC connector to the class path e.g. :

## Postgresql example
     export CLASSPATH=./postgresql-42.2.5.jar:$CLASSPATH
     # Set user and password
     export DB_USER=root
     export DB_PASS=password
     # Then you can run:
     javac Postgres.java
     java Postgres

## Mysql example     
     export CLASSPATH=/usr/share/java/mysql-connector-java-8.0.15.jar:$CLASSPATH
     # Or copy /mysql-connector-java to current directory
     export CLASSPATH=./mysql-connector-java-8.0.15.jar:$CLASSPATH 

     # Set user and password
     export DB_USER=root
     export DB_PASS=password
     # Then you can run:
     javac Mysql.java
     java Mysql

## Docker run

Spin up docker container, connect to postgres database using environment vars
and then drop to a sh shell.

     docker build -t my-java-app .
     docker run -it --rm --name my-running-app myjava
     docker run --network="host" --env DB_USER=postgres --env DB_PASS=password -it --rm --name my-running-app myjava
