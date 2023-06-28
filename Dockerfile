# Use a base image with Ubuntu and Node.js
FROM ubuntu:latest

# Update packages and install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm

# Set the working directory in the container
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/filipas13/stock_dashboard.git

# Navigate into the cloned repository
WORKDIR /app/stock_dashboard

# Install dependencies
RUN npm install

# Expose port 3000 for the web app
EXPOSE 3000

# Start the web app
CMD ["npm", "start"]
