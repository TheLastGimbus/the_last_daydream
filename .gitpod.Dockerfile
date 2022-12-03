FROM gitpod/workspace-full:latest

ENV PUB_CACHE=/home/gitpod/.pub_cache
ENV PATH="/home/gitpod/flutter/bin:$PATH"

RUN git clone https://github.com/flutter/flutter
RUN /home/gitpod/flutter/bin/flutter
