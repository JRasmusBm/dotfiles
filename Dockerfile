FROM ubuntu:20.04 as new-user

RUN apt-get update && \
      apt-get -y install sudo

ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
ENV TZ=Europe/Stockholm

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


FROM new-user as symlinked

USER docker
WORKDIR /home/docker/dotfiles

COPY . .

RUN sh scripts/symlink

CMD ["./scripts/verify_installation"]
