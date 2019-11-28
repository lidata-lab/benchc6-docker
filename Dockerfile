FROM lidata/benchc6:source

RUN mkdir /cpu2006 \
    && echo "yes" | ./install.sh -d /cpu2006
WORKDIR /cpu2006
RUN apt-get update \
    && apt install -y gcc g++ gfortran
RUN . ./shrc \
    && cp config/Example-linux64-amd64-gcc43+.cfg config/default.cfg \
    && runspec -c default.cfg -a build all
COPY entrypoint.sh ./
RUN rm -rf /home/cpu2006 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./entrypoint.sh"]
