#!/bin/bash

if [ -f /.tomcat_context_created ]; then
    echo "JNDI datasource already added in Tomcat context.xml"
    exit 0
fi


HOST=${MYSQL_HOST:-db}
PORT=${MYSQL_PORT:-3306}
DATABASE=${MYSQL_DATABASE:-osdb}
USER=${MYSQL_USER:-root}
PASSWORD=${MYSQL_PASSWORD:-password}

echo "=> add a JNDI datasource in Tomcat"
sed -i -r 's/<\/Context>//' ${CATALINA_HOME}/conf/context.xml
echo "<Resource name=\"${JNDI_NAME}\" auth=\"Container\" type=\"javax.sql.DataSource\"" >> ${CATALINA_HOME}/conf/context.xml
echo 'maxTotal="100" maxIdle="30" maxWaitMillis="10000"' >> ${CATALINA_HOME}/conf/context.xml
echo "username=\"${USER}\" password=\"${PASSWORD}\" driverClassName=\"com.mysql.jdbc.Driver\"" >> ${CATALINA_HOME}/conf/context.xml
echo "url=\"jdbc:mysql://${HOST}:${PORT}/${DATABASE}\"/>" >> ${CATALINA_HOME}/conf/context.xml
echo '</Context>' >> ${CATALINA_HOME}/conf/context.xml
echo "=> Done!"
touch /.tomcat_context_created
