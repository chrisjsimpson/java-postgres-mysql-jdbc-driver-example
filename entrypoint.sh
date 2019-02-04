#! /bin/sh
javac Postgres.java
export CLASSPATH=/usr/src/myapp/postgresql-42.2.5.jar:$CLASSPATH
java Postgres
/bin/sh

