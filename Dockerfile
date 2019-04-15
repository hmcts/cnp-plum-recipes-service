FROM hmcts/cnp-java-base:11

#ENV JAVA_OPTS ""

COPY build/libs/moj-rhubarb-recipes-service.jar /opt/app/

CMD ["moj-rhubarb-recipes-service.jar"]
