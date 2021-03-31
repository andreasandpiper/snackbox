FROM ruby:2.6.5

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  build-essential \
  postgresql-client \
  libpq-dev \
  ca-certificates \
  netcat-traditional \
  emacs \
  vim
RUN mkdir /snackbox
WORKDIR /snackbox

COPY Gemfile /snackbox/Gemfile
COPY Gemfile.lock /snackbox/Gemfile.lock
RUN gem install bundler:2.1.4
RUN bundle install

RUN npm install -g yarn@1.22.5

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . /snackbox

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]