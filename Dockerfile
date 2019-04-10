FROM ubuntu:16.04

RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-key 67D7ADA8
RUN apt-get update && apt-get install -y wget
RUN wget -O /etc/apt/sources.list.d/pcoip.list https://downloads.teradici.com/ubuntu/pcoip-dev.repo
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y pcoip-client

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
  mkdir -p /etc/sudoers.d/ && \
  mkdir -p /home/developer/.local/share && \
  mkdir -p /home/developer/.config/Teradici && \
  echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
  echo "developer:x:${uid}:" >> /etc/group && \
  echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
  chmod 0440 /etc/sudoers.d/developer && \
  chown ${uid}:${gid} -R /home/developer

USER developer

ENV HOME /home/developer

CMD pcoip-client
