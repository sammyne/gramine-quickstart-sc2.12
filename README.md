# gramine-quickstart-sc2.12

## Environment

- OpenJDK 1.8.0_312
- Scala 2.12.15
- gramine 1.0 described by [this Dockerfile][gramine-Dockerfile]

## Problem reproduction

### 1. Dockerize 
```bash
docker build -t gramine-quickstart-sc2.12:alpha .
```

### 2. Run

```bash
docker run --rm                                   \
  --device /dev/kmsg:/dev/kmsg                    \
  --device /dev/gsgx:/dev/gsgx                    \
  --device /dev/sgx_enclave:/dev/sgx/enclave      \
  --device /dev/sgx_provision:/dev/sgx/provision  \
  gramine-quickstart-sc2.12:alpha
```

With errors going as

```bash
[P1:T1:] error: Error opening executable /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java: -2
[P1:T1:] error: Error during shim_init() in init_important_handles (-2)
```

[gramine-Dockerfile]: https://github.com/sammyne/ghcr.io/blob/main/gramine/1.0/ubuntu20.04/Dockerfile
