## Quickstart
(thanks Sameer Naik - sameersbn)

Start Squid using:

```bash
docker run --name squid -d --restart=always \
  --publish 3128:3128 \
  --volume /srv/docker/squid/:/squid \
  babim/squid
```
Volume dir:
```
/squid/cache
/squid/log
/squid/config
```

## authentication
The user must specify authentication credentials via the following environment variables:

```
-e AUTH=true
USERNAME=foo (default)
PASSWORD=bar (default)
```

## Public access
You can access from internet via the following environment variables:

```
-e PUBLIC=true
```

## Usage

Configure your web browser network/connection settings to use the proxy server which is available at `172.17.42.1:3128`

If you are using Linux then you can also add the following lines to your `.bashrc` file allowing command line applications to use the proxy server for outgoing connections.

```bash
export ftp_proxy=http://172.17.42.1:3128
export http_proxy=http://172.17.42.1:3128
export https_proxy=http://172.17.42.1:3128
```

To use Squid in you Docker containers add the following line to your `Dockerfile`.

```dockerfile
ENV http_proxy=http://172.17.42.1:3128 \
    https_proxy=http://172.17.42.1:3128 \
    ftp_proxy=http://172.17.42.1:3128
```

## Logs

To access the Squid logs, located at `/var/log/squid/`, you can use `docker exec`. For example, if you want to tail the access logs:

```bash
docker exec -it squid tail -f /var/log/squid/access.log
```

You can also mount a volume at `/var/log/squid/` so that the logs are directly accessible on the host.
