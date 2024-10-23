# Dockerfile

# Use the official Ruby image as the base image
FROM ruby:3.1.2

# Install dependencies for PostgreSQL and other gems
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (if necessary)
# RUN bundle exec rake assets:precompile

# Expose the application port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
