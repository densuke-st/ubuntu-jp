FROM ubuntu:22.04
ENV TZ=Asia/Tokyo
RUN --mount=type=cache,target=/var/lib/apt \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install --auto-remove --purge -y tzdata \
    && cd /etc && ln -sf ../usr/share/zoneinfo/${TZ} ./localtime \
    && echo "${TZ}" > timezone \
    && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure tzdata
RUN --mount=type=cache,target=/var/lib/apt \
    --mount=type=cache,target=/var/cache/apt \
    apt-get install -y locales \
    && sed -i.bak -e 's;^# ja_JP.UTF-8;ja_JP.UTF-8;' /etc/locale.gen \
    && locale-gen
ENV LC_ALL=ja_JP.UTF-8

