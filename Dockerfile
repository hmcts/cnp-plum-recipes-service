ARG PLATFORM=""
FROM hmctsprod.azurecr.io/base/java${PLATFORM}:pr-25-distroless

COPY build/libs/moj-rhubarb-recipes-service.jar /opt/app/
COPY lib/applicationinsights.json /opt/app/

CMD ["moj-rhubarb-recipes-service.jar"]
