# gramine-quickstart-sc2.12

## Environment

- OpenJDK 1.8.0_312
- Scala 2.12.15
- gramine [86f0d3f][gramine-rev] described by [this Dockerfile][gramine-Dockerfile]

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

[gramine-Dockerfile]: https://github.com/sammyne/ghcr.io/blob/main/gramine/86f0d3f/ubuntu20.04/Dockerfile
[gramine-rev]: https://github.com/gramineproject/gramine/commit/86f0d3f047567670dab5f8b39e4a9b9e5db97020
