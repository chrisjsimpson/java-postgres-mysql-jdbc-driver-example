FROM openjdk:13-alpine
COPY *.java /usr/src/myapp/
COPY postgresql-42.2.5.jar /usr/src/myapp/
COPY entrypoint.sh /usr/src/myapp/
WORKDIR /usr/src/myapp
# Override the username/password with docker run --env e.g:
# docker run --network="host" --env DB_USER=fred --env DB_PASS=secret -it --rm --name my-app myjava
ENV DB_USER=postgres
ENV DB_PASS=password
CMD ["./entrypoint.sh"]
