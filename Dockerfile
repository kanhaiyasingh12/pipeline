# Use the official Nginx image from the Docker Hub
FROM docker.io/nginx:latest

# Cpy custom Nginx configuration (optional)
# If you have a custom nginx.conf, copy it into the container
# COPY nginx.conf /etc/nginx/nginx.conf

# Copy static website files (HTML, CSS, JS, etc.)
# Assuming your website files are in a folder called 'html'
COPY ./html /usr/share/nginx/html

# Expose port 80 to access the web server
EXPOSE 80

# Start Nginx in the foreground (default in the official image)
CMD ["nginx", "-g", "daemon off;"]
