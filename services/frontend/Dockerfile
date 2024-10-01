# Use Nginx as the base image
FROM nginx:mainline-perl


# Set the working directory to /usr/share/nginx/html (default for Nginx)
WORKDIR /usr/share/nginx/html/

# Copy your web interface files to the Nginx HTML directory
COPY ./src /usr/share/nginx/html/

# Copy your custom nginx.conf file to the appropriate directory
COPY ./nginx.conf /etc/nginx/nginx.conf.template

# Expose the port Nginx will serve (e.g., port 80)
EXPOSE 80

# Run envsubst to substitute environment variables and generate the final nginx.conf
CMD envsubst '$BE_CARBS_URL $BE_DAIRY_URL $BE_MEATS_URL $BE_VEGETABLES_URL' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;' 