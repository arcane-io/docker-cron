# docker-cron #

## Usage

In order to create cron jobs add environment properties that start with 'CRON_' (the name must be unique) and have the value with the format ```<cron-value> <command>```.

The cron commands output can be found in '/var/log/cron.log' .

```bash
tail -f /var/log/cron.log
```

## Examples

Simple docker-compose example

```bash
docker-compose up -f example/docker-compose.yml
```