# Health Checks

Building Health Checks into your Docker images is really easy.  When starting up a complex stack of containers, how do we know that they are "healthy" ?
Health checks won't guarantee that an application is working but does give an early warning when something isn't right.

If you are using supervisord within a container to start multiple services then the following 3 lines can be added to the Dockerfile and you'll have a very basic health check.

```
ADD https://raw.githubusercontent.com/tomwillfixit/healthchecks/master/supervisord_healthcheck.sh /usr/local/bin/health
RUN chmod +x /usr/local/bin/health
HEALTHCHECK --interval=3s --timeout=5s CMD /usr/local/bin/health
```

After building the docker image with the lines above included you can start a container and query the health.
```
docker run -d --name nginx nginx_supervisord

docker inspect --format='{{.State.Health.Status}}' nginx
healthy

```

In a nginx Dockerfile the following can be used :

```
HEALTHCHECK --interval=10s --timeout=3s CMD curl http://localhost:80 || exit 1
```

Full instructions on how to use HEALTHCHECKS can be found [here](https://docs.docker.com/engine/reference/builder/).
