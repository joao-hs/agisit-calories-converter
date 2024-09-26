# Use an official Nginx image as the base image
FROM nginx:alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the frontend files from the host to the container
COPY src/index.html /usr/share/nginx/html/index.html
COPY src/style.css /usr/share/nginx/html/style.css
COPY src/script.js /usr/share/nginx/html/script.js

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
