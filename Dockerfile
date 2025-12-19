# distro os.
FROM ubuntu:bionic

# mkdir users
LABEL maintainer="Takayuki Kamiyama <karuma.reason@gmail.com>"

# build package
RUN apt-get update && apt-get install -y \
git ruby-dev sqlite3 libxslt1-dev libxml2-dev build-essential patch \
libsqlite3-dev libcurl4-openssl-dev curl && apt-get clean

# node.js
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN NODE_MAJOR=25 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y && apt-get clean

# npm install --global [npm|yarn]
RUN npm install -g npm@latest

# locale
RUN apt install -y language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8
RUN echo 'eval "LANG=ja_JP.UTF-8"' >> ~/.bashrc
RUN echo 'eval "export LANG"' >> ~/.bashrc

# utf8
ENV RUBYOPT -EUTF-8

# ruby
FROM ruby:3.4.7

# install
RUN mkdir /overdrive_nym
ENV APP_ROOT /overdrive_nym
WORKDIR $APP_ROOT
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
COPY . /overdrive_nym
RUN gem update --system ${RUBYGEMS_VERSION} && BUNDLER_VERSION=${BUNDLER_VERSION} bundle install
COPY ["package.json", "yarn.lock", "./"]
RUN yarn install
COPY . .
RUN rm /bin/sh && mv /bin/sh_tmp /bin/sh
ADD . $APP_ROOT

EXPOSE 9292
