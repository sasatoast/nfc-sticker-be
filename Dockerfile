FROM ruby:3.4.4

# Node.js, npm, yarn, MySQL client
RUN apt-get update -qq && \
    apt-get install -y nodejs npm yarnpkg postgresql-client && \
    ln -s /usr/bin/yarnpkg /usr/bin/yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
