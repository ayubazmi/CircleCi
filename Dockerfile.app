FROM ruby:3.1.2

RUN apt-get update -qq && \
    apt-get install -y curl gnupg2 postgresql-client && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

RUN yarn install
RUN bundle exec rake assets:precompile

EXPOSE 3000

ENV DB_HOST=postgres-db

CMD bash -c "until pg_isready -h $DB_HOST -p 5432 -U postgres; do sleep 1; done && bundle exec rails db:migrate && exec rails server -b 0.0.0.0"