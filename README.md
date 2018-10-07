# Docker Crontab

[![Docker Pulls](https://img.shields.io/docker/pulls/arcaneio/crontab.svg?style=flat)](https://hub.docker.com/r/arcaneio/crontab/)
[![Docker Automated build](https://img.shields.io/docker/automated/arcaneio/crontab.svg?style=flat)](https://hub.docker.com/r/arcaneio/crontab/)
[![Docker Build Status](https://img.shields.io/docker/build/arcaneio/crontab.svg?style=flat)](https://hub.docker.com/r/arcaneio/crontab/)
[![license](https://img.shields.io/github/license/arcane-io/docker-cron.svg)](https://github.com/arcane-io/docker-cron)

## Usage

In order to create cron jobs add environment properties that start with 'CRON_' (the name must be unique) and have the value with the format ```<cron-value> <command>```.

The cron commands output can be found in '/var/log/cron.log' .

```bash
tail -f /var/log/cron.log
```

## Examples

### Simple docker-compose example

```yaml
version: '3'

services:
  cron:
    image: arcaneio/crontab
    container_name: arcaneio-cron-example
    environment:
      CRON_SAMPLE: '* * * * * echo 1 minute cron'
      CRON_ANOTHER_SAMPLE: '*/5 * * * * echo 5 minute cron'
```

### Synchronize ftp data

Synchronize data from ftp location and share it with the http server through shared volume.

```yaml
version: '3'

volumes:
  local-data:

services:
  consumer:
    image: httpd
    container_name: ftp-data-consumer
    ports:
      - 8001:80
    volumes:
      - local-data:/usr/local/apache2/htdocs/data
  cron:
    image: arcaneio/crontab
    container_name: test-data-sync
    environment:
      CRON_RSYNC: '*/5 * * * * lftp -c "set ftp:list-options -a; open ftp://tgftp.nws.noaa.gov/data/tampa/; lcd /opt/synchronized-data; mirror --only-missing --only-newer --verbose --delete --allow-chown --allow-suid --no-umask --parallel=5"​'
    volumes:
      - local-data:/opt/synchronized-data
```

Synchronize data from ftp location and share it with the http server through shared volume and ftp address mounted as volume.

```yaml
version: '3'

volumes:
  local-data:
  ftp-location:
    driver: valuya/curlftpfs:next # NOTE make sure you have the driver plugin installed: docker plugin install valuya/curlftpfs:next DEBUG=1
    driver_opts:
      address: ftp://tgftp.nws.noaa.gov/data/tampa/

services:
  consumer: 
    image: httpd
    container_name: ftp-data-consumer
    ports:
      - 8001:80
    volumes:
      - local-data:/usr/local/apache2/htdocs/data
  cron:
    image: arcaneio/crontab
    container_name: test-data-sync
    environment:
      CRON_RSYNC: "*/5 * * * * rsync -rzvt --inplace --update --progress --stats /opt/ftp-data/ /opt/synchronized-data"
    volumes:
      - ftp-location:/opt/ftp-data
      - local-data:/opt/synchronized-data

```

View the data by accessing http://localhost:8001/data/ (or http://192.168.99.100:8001/data/ if using Docker Toolbox)