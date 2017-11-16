FROM alpine

RUN wget http://public.portalier.com/alpine/julien@portalier.com-56dab02e.rsa.pub -O /etc/apk/keys/julien@portalier.com-56dab02e.rsa.pub
RUN echo http://public.portalier.com/alpine/testing >> /etc/apk/repositories
RUN apk update && apk add crystal gcc shards
