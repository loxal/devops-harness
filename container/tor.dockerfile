FROM alpine:latest

MAINTAINER Alexander Orlov <alexander.orlov@loxal.net>

### execute as non-root user
ENV SVC_USR svc_usr
RUN adduser -D -g $SVC_USR $SVC_USR
USER $SVC_USR
WORKDIR /home/$SVC_USR
### /execute as non-root user

RUN mkdir -p build/resources/main
ADD ubuntu/etc/tor/torrc /etc/tor
COPY ubuntu/etc/tor/tor-exit-notice.html /etc/tor

EXPOSE 9001 9030

CMD ls
