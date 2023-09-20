# Use an official Node.js base image

FROM node:14

# Set the working directory inside the container for the Node.js server

WORKDIR /app

# Copy package.json and package-lock.json to the container

COPY package*.json ./

# Install Node.js project dependencies

RUN npm install

# Copy the rest of the Node.js project files to the container

COPY . .

# Build the Vue.js project

RUN npm run build

# Expose the port your Node.js server will run on

EXPOSE 3000
# Install Nginx

RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx configuration

RUN rm /etc/nginx/sites-enabled/default

# Copy the Nginx configuration for your project

COPY nginx.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Expose port 80 for Nginx

EXPOSE 80

# Install supervisord to manage multiple processes

RUN apt-get install -y supervisor

# Copy the supervisord configuration file

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start supervisord to manage Node.js and Nginx processes

CMD ["/usr/bin/supervisord"]
