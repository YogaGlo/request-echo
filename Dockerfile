FROM quay.io/yogaglo/alpine-node:stable
MAINTAINER YogaGlo DevOps <ops@yogaglo.com>

RUN apk add --update \
  vim \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/echo
WORKDIR /opt/echo

COPY package.json ./

RUN npm install --production

COPY echo.js ./

ENTRYPOINT ["node", "echo.js"]