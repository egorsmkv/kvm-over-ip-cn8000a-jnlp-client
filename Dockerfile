# Copyright and author: Sebastian Daschner
# License: CC BY-NC-SA 4.0
# The source: https://blog.sebastian-daschner.com/entries/java_web_start_in_docker_sandbox

FROM williamyeh/java7

# xorg and sudo is needed to run X as non-root
RUN apt-get update && \
    apt-get install -y xorg sudo

# run X as non-root
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/dockeruser && \
    echo "dockeruser:x:${uid}:${gid}:Developer,,,:/home/dockeruser:/bin/bash" >> /etc/passwd && \
    echo "dockeruser:x:${uid}:" >> /etc/group && \
    echo "dockeruser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dockeruser && \
    chmod 0440 /etc/sudoers.d/dockeruser && \
    chown ${uid}:${gid} -R /home/dockeruser

COPY jnlp/ jnlp/

USER dockeruser

ENV HOME /home/dockeruser
