FROM heroku/heroku:20-build

RUN apt update \
    && apt upgrade -y \
    && apt install gfortran -y

RUN mkdir /build \
    && mkdir -p /layers/plotly_r/r \
    && mkdir /output

WORKDIR /build

RUN curl -sSL https://cran.r-project.org/src/base/R-4/R-4.0.5.tar.gz | tar xzf - \
    && cd R-4.0.5 \
    && ./configure --with-x=no --enable-java=no --prefix=/layers/plotly_r/r \
    && make \
    && make install

RUN cp -v /usr/lib/x86_64-linux-gnu/libgfortran.so.5.0.0 /layers/plotly_r/r/lib/R/lib/libgfortran.so.5

WORKDIR /layers/plotly_r/r

RUN tar czlf /output/R-4.0.5-binaries-latest.tar.gz ./ \
    && ls -la /output
