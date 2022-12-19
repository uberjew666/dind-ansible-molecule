FROM qwe1/debdocker:20.10

ENV umask=022

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends python3 libc6-dev python3-pip gcc git python3-dev python3-setuptools python3-wheel libssl-dev openssh-client

RUN pip3 install --upgrade pip

COPY requirements.txt /tmp/

RUN pip3 install -r /tmp/requirements.txt

RUN apt-get purge --autoremove -y libc6-dev gcc libssl-dev python3-dev python3-wheel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /root/.cache

RUN groupadd -g 998 docker

RUN useradd -m -s /bin/bash user && \
    gpasswd -a user docker

USER user

CMD ["bash"]
