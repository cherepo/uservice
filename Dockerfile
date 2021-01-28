FROM adoptopenjdk/openjdk15:jdk-15.0.1_9-alpine-slim

RUN apk add --update \
  curl jq ca-certificates openssl tzdata \
  && rm -rf /var/cache/apk/*

# sane defaults for java's DNS cache - because we don't want to cache for infinity ... imagine that ...
# RUN sed -i 's/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=60/g' $JAVA_HOME/conf/security/java.security

# default java options that can be overridden from ansible
# Java VM Options (-X flags)
ENV JAVA_MEM_OPTS -Xms256m -Xmx256m -XX:MaxMetaspaceSize=128m
# Java System Properties (-D flags)
# ENV JAVA_BASE_PROPS  -Djava.security.properties=$JAVA_HOME/conf/security/java.security -Djava.security.egd=file:/dev/./urandom

# Install NewRelic Agent - v4.7.0 as at 09-10-2018
WORKDIR /app
ADD https://download.newrelic.com/newrelic/java-agent/newrelic-agent/4.11.0/newrelic-java-4.11.0.zip newrelic-java.zip
RUN unzip newrelic-java;\
    rm newrelic-java.zip

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=15s --start-period=4m \
	CMD curl -f http://localhost:8080/manage/health || exit 1

# Set the timezone.
ENV TZ=Australia/Brisbane
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN addgroup -S app && adduser -S app -G app
USER app:app

ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} /app/app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]
