FROM ruby:3.1.2

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y curl gnupg2 postgresql-client && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn sass

# Add esbuild binary manually (static Linux version)
RUN yarn global add esbuild && \
    ln -sf /usr/local/share/.config/yarn/global/node_modules/esbuild/bin/esbuild /usr/local/bin/esbuild

# Set the working directory
WORKDIR /app

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy application code
COPY . .

# Install JS deps and ensure esbuild binary is executable
RUN yarn install

# Precompile assets
RUN bundle exec rake assets:precompile

EXPOSE 3000
ENV DB_HOST=postgres-db

# Wait for DB and start server
CMD bash -c "until pg_isready -h $DB_HOST -p 5432 -U postgres; do sleep 1; done && bundle exec rails db:migrate && exec rails server -b 0.0.0.0"
