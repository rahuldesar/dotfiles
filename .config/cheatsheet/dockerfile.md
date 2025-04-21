---
title: Dockerfile
category: Devops
prism_languages: [docker]
updated: 2019-10-20
---

## Reference

### Inheritance

```dockerfile
FROM ruby:2.2.2
```

### Variables

```dockerfile
ENV APP_HOME /myapp
RUN mkdir $APP_HOME
```

```dockerfile
ARG APP_HOME=""
RUN mkdir $APP_HOME
```

### Initialization

```dockerfile
RUN bundle install
```

```dockerfile
WORKDIR /myapp
```

```dockerfile
VOLUME ["/data"]
# Specification for mount point
```

```dockerfile
ADD file.xyz /file.xyz
COPY --chown=user:group host_file.xyz /path/container_file.xyz
```

### Run commands in strict shell

```dockerfile
ENV my_var
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

# With strict mode:
RUN false # fails build like using &&
RUN echo "$myvar" # will throw error due to typo
RUN true | false # will bail out of pipe
```

Using `shell` will turn on strict mode for shell commands.

### Onbuild

```dockerfile
ONBUILD RUN bundle install
# when used with another file
```

### Commands

```dockerfile
EXPOSE 5900
CMD    ["bundle", "exec", "rails", "server"]
```

### Entrypoint

```dockerfile
ENTRYPOINT ["executable", "param1", "param2"]
ENTRYPOINT command param1 param2
```

Configures a container that will run as an executable.

```dockerfile
ENTRYPOINT exec top -b
```

This will use shell processing to substitute shell variables, and will ignore any `CMD` or `docker run` command line arguments.

### Metadata

```dockerfile
LABEL version="1.0"
```

```dockerfile
LABEL "com.example.vendor"="ACME Incorporated"
LABEL com.example.label-with-value="foo"
```

```dockerfile
LABEL description="This text illustrates \
that label-values can span multiple lines."
```

## See also

- <https://docs.docker.com/engine/reference/builder/>
