FROM node:5.5.0
MAINTAINER Dan Lynn <docker@danlynn.org>

# Note: npm version is 3.3.12
RUN npm install -g ember-cli@2.3.0-beta.1
RUN npm install -g bower@1.7.2
RUN npm install -g phantomjs-prebuilt@2.1.3

# install python dev for comiling watchman
RUN apt-get update \
      && apt-get install -y --no-install-recommends python-dev \
      && rm -rf /var/lib/apt/lists/*

# install watchman
RUN \
  git clone https://github.com/facebook/watchman.git &&\
  cd watchman &&\
  git checkout v4.3.0 &&\
  ./autogen.sh &&\
  ./configure &&\
  make &&\
  make install

EXPOSE 4200 35729
WORKDIR /myapp

# run ember server on container start
ENTRYPOINT ["/usr/local/bin/ember"]
CMD ["server"]
