FROM mhart/alpine-node:0.12.9
MAINTAINER Eugene Brodsky <eugene@bravoactual.io>

RUN apk add --update \
  vim \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/echo
WORKDIR /opt/echo

COPY package.json ./

RUN npm install --production

COPY echo.js ./

ENTRYPOINT ["node", "echo.js"]