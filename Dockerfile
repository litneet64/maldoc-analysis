FROM python:2.7

ARG DIR="/playground"
ARG UID="1000"
ARG GID="1000"

# create unprivileged user
RUN mkdir -p $DIR \\
    && groupadd -g $GID analyst \
    && useradd -m -s /bin/bash -u $UID -g $GID analyst \
    && chown -R $UID:$GID $DIR

WORKDIR $DIR

# install yara and vim
RUN apt update && apt install -y yara vim

# download and install tools
RUN curl https://didierstevens.com/files/software/oledump_V0_0_58.zip > oledump.zip \
    && unzip oledump.zip \
    && rm oledump.zip \
    && chmod +x *.py \
    && pip install -U https://github.com/decalage2/ViperMonkey/archive/master.zip \
    && pip install olefile oletools yara-python

USER analyst
CMD ["/bin/bash"]
