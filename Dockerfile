FROM tinslice/crontab:1.0

RUN apk add --no-cache \
            bzip2 \
            gzip \
            tar \
            curl \
            jq \
            wget \
            ca-certificates \
            rsync \
            lftp 
