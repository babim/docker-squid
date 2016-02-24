(Thanks sameersbn)

## Quickstart

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
## Command-line arguments

You can customize the launch command of the Squid server by specifying arguments to `squid3` on the `docker run` command. For example the following command prints the help menu of `squid3` command:

```bash
docker run --name squid -it --rm \
  --publish 3128:3128 \
  --volume /srv/docker/squid/cache:/var/spool/squid3 \
  babim/squid -h
```

## Configuration

Squid is a full featured caching proxy server and a large number of configuration parameters. To configure Squid as per your requirements edit the default [squid.conf](squid.conf) and volume mount it at `/etc/squid3/squid.conf`.

```bash
docker run --name squid -d --restart=always \
  --publish 3128:3128 \
  --volume /path/to/squid.conf:/etc/squid3/squid.conf \
  --volume /srv/docker/squid/cache:/var/spool/squid3 \
  babim/squid
```

To reload the Squid configuration on a running instance you can send the `HUP` signal to the container.

```bash
docker kill -s HUP squid
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

To access the Squid logs, located at `/var/log/squid3/`, you can use `docker exec`. For example, if you want to tail the access logs:

```bash
docker exec -it squid tail -f /var/log/squid3/access.log
```

You can also mount a volume at `/var/log/squid3/` so that the logs are directly accessible on the host.

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using Docker version `1.3.0` or higher you can access a running containers shell by starting `bash` using `docker exec`:

```bash
docker exec -it squid bash
```
