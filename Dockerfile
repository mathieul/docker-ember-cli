FROM node:5.4.0
MAINTAINER Dan Lynn <docker@danlynn.org>

# Note: npm is v3.3.12
RUN npm install -g ember-cli@2.2.0-beta.4
RUN npm install -g bower@1.7.1
RUN npm install -g phantomjs@1.9.19

# install watchman
RUN \
	git clone https://github.com/facebook/watchman.git &&\
	cd watchman &&\
	git checkout v3.5.0 &&\
	./autogen.sh &&\
	./configure &&\
	make &&\
	make install

EXPOSE 4200 35729
WORKDIR /myapp

# run ember server on container start
ENTRYPOINT ["/usr/local/bin/ember"]
CMD ["server"]
