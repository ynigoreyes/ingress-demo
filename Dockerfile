FROM node:10-alpine

ARG svc_name

WORKDIR /usr/src/app

# Installing dependencies
COPY $svc_name/package.json /usr/src/app
COPY $svc_name/yarn.lock /usr/src/app
RUN yarn --pure-lockfile

ADD ./$svc_name/package.json /tmp/package.json
RUN cd /tmp && yarn
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/

COPY $svc_name/pages /usr/src/app/pages
COPY $svc_name/server.js /usr/src/app/server.js

RUN yarn build

# Running the app
CMD ["yarn", "start"]
