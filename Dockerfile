FROM arcaneio/mini-tools:1.1

RUN apk add --no-cache \
            lftp 
            
RUN mkdir /opt /opt/scripts

COPY scripts/* /opt/scripts/

RUN chmod +x -R /opt/scripts

ADD fs/etc/supervisord.d/* /etc/supervisord.d/