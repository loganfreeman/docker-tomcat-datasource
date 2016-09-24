### docker tomcat customizable with env-file

### instructions


first create a db container
```shell
docker run --name mysql -e MYSQL_ROOT_PASSWORD=password -e MYSQL_USER=user -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=example -d mysql:latest
```

then build the image from Dockerfile
```shell
docker build -t my-tomcat-server .
```

last run the tomcat container
```shell
docker run -d -p 8888:8080 --env-file ./.docker-env --name app --link mysql:db my-tomcat-server
```


.env-file content
```
TOMCAT_USER=admin
TOMCAT_PASS=admin
JNDI_NAME=jdbc/example
MYSQL_HOST=db
MYSQL_PORT=3306
MYSQL_DATABASE=database
MYSQL_USER=user
MYSQL_PASSWORD=password
```

login
```shell
docker exec -it my-tomcat-server bash
cd ${CATALINA_HOME}
```

open in browser: [tomcat manager](http://localhost:8888/manager/html)
