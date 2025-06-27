FROM ruby:3.1.2

# Install system dependencies, Node.js 18, and yarn
RUN apt-get update -qq && \
    apt-get install -y curl gnupg2 postgresql-client && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn sass

# Set the working directory
WORKDIR /app

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . .

# Install JS dependencies and fix esbuild permission
RUN yarn install && chmod +x ./node_modules/.bin/esbuild

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port
EXPOSE 3000

# Set environment variable for DB host
ENV DB_HOST=postgres-db

# Entrypoint command: wait for DB, run migrations, then start server
CMD bash -c "until pg_isready -h $DB_HOST -p 5432 -U postgres; do sleep 1; done && bundle exec rails db:migrate && exec rails server -b 0.0.0.0"
