FROM akhilkumar7947/sentinelhub:v0.0.5

EXPOSE 8080
EXPOSE 26656
EXPOSE 26657
EXPOSE 1317
EXPOSE 9090

ENV PACKAGES curl make libc-dev bash gcc linux-headers python3 py3-pip p7zip
RUN apk add --no-cache $PACKAGES

RUN apk add --update ca-certificates
RUN pip3 install toml

RUN mkdir /node

COPY app.toml /node/
COPY config.toml /node/

COPY run.sh /node/
RUN chmod 555 /node/run.sh

COPY ./patch_config_toml.py /node/

CMD /node/run.sh
