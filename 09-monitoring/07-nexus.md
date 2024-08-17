install with docker compose 

```shell
version: "3.4"
services:
  nexus:
    container_name: nexus
    image: sonatype/nexus3:latest
    networks:
      - registry
    ports:
      - 8081:8081
      - 81:81
      - 82:82
    volumes:
    - /data/registry/nexus-data:/nexus-data

networks:
  registry:

```

and then give permission

```bash
chown -R 200:200  /data/registry/nexus-data
```

```shell
chown -R 200:200 /data/registry/
chown -R 200:200 /data/registry/nexus-data
```

up and run

```shell
docker-compose up -d
```

