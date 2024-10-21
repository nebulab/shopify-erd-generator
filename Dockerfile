# Dockerfile
FROM ruby:latest

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install the dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Copy the erd-files directory
COPY erd-files erd-files

# Set execute permissions for the run.sh script
RUN chmod +x run.sh

# Set default environment variables (can be overridden in docker-compose.yml)
ENV SHOP_URL="your-shop-url"
ENV ACCESS_TOKEN="your-access-token"

# Command to run the main.rb script
CMD ["ruby", "main.rb"]