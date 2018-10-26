FROM alpine:edge

MAINTAINER hanamichi <hanamichi@hanamichi.wiki>

RUN apk update && \
    apk add --no-cache --update bash && \
    mkdir -p /conf && \
    mkdir -p /conf-copy && \
    mkdir -p /data && \
    apk add --no-cache --update aria2 && \
    apk add git && \
    git clone https://github.com/ziahamza/webui-aria2 /aria2-webui && \
    mv /aria2-webui/docs/* /aria2-webui && \
    rm /aria2-webui/.git* -rf && \
    apk del git && \
    apk add --update darkhttpd

ADD script/start.sh /conf-copy/start.sh
ADD conf/aria2.conf /conf-copy/aria2.conf
ADD script/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 80
EXPOSE 8080

CMD ["/conf-copy/start.sh"]
