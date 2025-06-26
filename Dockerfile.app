FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y curl gnupg2 postgresql-client && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn sass esbuild  # ✅ Install required JS tools globally

WORKDIR /app

# Copy Gemfiles and install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the rest of the application
COPY . .

# Install JS packages
RUN yarn install

# Compile assets
RUN bundle exec rake assets:precompile

EXPOSE 3000

ENV DB_HOST=postgres-db

# Wait for DB then migrate and start server
CMD bash -c "until pg_isready -h $DB_HOST -p 5432 -U postgres; do sleep 1; done && bundle exec rails db:migrate && exec rails server -b 0.0.0.0"
