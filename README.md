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

# Kubernetes

## Install MicroK8s
[MicroK8s](https://github.com/ubuntu/microk8s/blob/master/README.md) is a [snap](https://snapcraft.io/) that you can run locally to simulate a kubernetes environment on your laptop.

```
snap install microk8s --classic --channel=1.12/stable
```

You can read more on the MicroK8s release channels in the [Release Channels and Upgrades](docs/release-channels.md) doc.

At any point you can check MicroK8s' availability with:

```
microk8s.status
```

During installation you can use the `--wait-ready` flag to wait for the kubernetes services to initialise:

```
microk8s.status --wait-ready
```

> In order to install MicroK8s make sure
> - port 8080 is not used and
> - if you have AppArmor enabled (check with `sudo apparmor_status`) you do not have any other [dockerd installed](docs/dockerd.md). You can use the dockerd coming with MicroK8s.

```
microk8s.enable dns dashboard
```

## Run on kubernetes 

The following will deploy to Kubernetes.

### Build the image and push to local docker registry:

```
microk8s.docker build -t myjava .
microk8s.docker tag myjava localhost:32000/myjava
microk8s.docker push localhost:32000/myjava
```

Deploy the app to kubernetes

```
microk8s.kubectl create -f k8.yaml
```

Note that the default `Postgres.java` file referes to "postgres-service" as the
host for the postgres instance. This is refering to the `postgres-service` 
defines in `k8.yaml`. This resolves to the postgres instance within a kubernetes
pod (an `nslookup postgres-service` resolves to the ip of the postgres 
container.

### View kubernetes pod->container logs

First get pod name:

```
microk8s.kubectl get pods
```
View the logs (e.g. "org.postgresql.util.PSQLException: FATAL: database "fred_db" does not exist"):

```
microk8s.kubectl logs myjavaapp-64974db66b-mh87j
```
If you see that error, your java app has connected to Postgres correctly using the secrets, and
via the postgres service to the running database.

To delete your kubernetes deplpoyment, manually or run the following file:
```
./delete.sh # from this repo
```
