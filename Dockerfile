#FROM hmcts/cnp-java-base:openjdk-8u191-jre-alpine3.9-1.0
FROM hmcts/cnp-java-base:openjdk-8u191-jre-alpine3.9-1.1-alpha


ENV JAVA_OPTS ""

COPY build/libs/moj-rhubarb-recipes-service.jar /opt/app/

CMD ["moj-rhubarb-recipes-service.jar"]
