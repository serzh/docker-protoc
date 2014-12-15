FROM ubuntu:14.04

RUN apt-get -yqq update && \
    apt-get -yqq install \
      build-essential \
      curl \
      dh-autoreconf \
      git \
      pkg-config \
      qt5-default \
      unzip && \
    # Install protobuf
    git clone https://github.com/google/protobuf.git /protobuf && \
    cd /protobuf && \
      git checkout v2.6.1 && \
      ./autogen.sh && \
      ./configure && \
      make && \
      make install && \
      ldconfig && \
    # Install protoc-gen-doc
    git clone https://github.com/estan/protoc-gen-doc.git /protoc-gen-doc && \
    cd /protoc-gen-doc && \
      qmake && \
      make && \
      cp protoc-gen-doc /usr/local/bin && \
    # Cleanup
    apt-get -yqq remove git curl unzip curl dh-autoreconf && \
    apt-get -yqq clean && \
    rm -rf /protobuf /protoc-gen-doc

ENTRYPOINT ["protoc"]
CMD ["--help"]
