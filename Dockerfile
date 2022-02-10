# -------------------------------------------------------------------
# Minimal dockerfile from alpine base
#
# Instructions:
# =============
# 1. Create an empty directory and copy this file into it.
#
# 2. Create image with: 
#	docker build --tag timeoff:latest .
#
# 3. Run with: 
#	docker run -d -p 3000:3000 --name alpine_timeoff timeoff
#
# 4. Login to running container (to update config (vi config/app.json): 
#	docker exec -ti --user root alpine_timeoff /bin/sh
# --------------------------------------------------------------------
FROM alpine:3.8

EXPOSE 3000

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.docker.cmd="docker run -d -p 3000:3000 --name alpine_timeoff"

RUN apk add curl 
RUN apk add --no-cache libgcc libstdc++ curl
RUN curl -fLO https://github.com/oznu/alpine-node/releases/download/14.18.1/node-v14.18.1-linux-x86_64-alpine.tar.gz
RUN tar -xzf node-v14.18.1-linux-x86_64-alpine.tar.gz -C /usr --strip-components=1 --no-same-owner

RUN apk add --no-cache \
    git \
    make \
    python \
    vim \
    build-base
    
RUN adduser --system app --home /app
USER app
WORKDIR /app
#Arreglar esta parte
COPY --chown=app .. timeoff-management
WORKDIR /app/timeoff-management

RUN npm install

CMD npm start


