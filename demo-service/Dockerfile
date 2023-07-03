FROM node:16-alpine
COPY . /srv/
RUN cd /srv/ && \
    npm i --only=prod --no-audit
WORKDIR /srv/
ENV NODE_ENV production
EXPOSE 80
CMD PORT=80 npm run prod
