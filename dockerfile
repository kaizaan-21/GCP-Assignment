# Using a lightweight Alpine image with Node.js version 19.7.0 as the base
FROM node:19.7-alpine
 
# Set the default Node environment to production
ENV NODE_ENV production
 
# Create a new directory 'labone' at the root level
RUN mkdir /labone
 
# Assign ownership of the 'labone' directory to the 'node' user
RUN chown -R node:node /labone
 
# Set the 'labone' directory as the working directory
WORKDIR /labone
 
# Switch to the 'node' user for subsequent commands
USER node
 
# Create necessary directories for application configuration with proper permissions
RUN mkdir /labone/etc && \
    mkdir /labone/etc/todos && \
    chown -R node:node /labone/etc
 
# Copy all files from the source to the 'labone' directory and adjust file ownership
COPY --chown=node:node . /labone
 
# Install Node.js packages using npm
RUN npm install
 
# Expose port 3000 for incoming connections
EXPOSE 3000
 
# Set the default command to start the application
CMD ["node", "src/index.js"]
