# Use a lightweight Alpine image with Node.js version 19.7.0 as the base
FROM node:19.7-alpine

# Set the default Node environment to production
ENV NODE_ENV=production

# Create a new directory 'labone' at the root level
WORKDIR /labone

# Assign ownership of the 'labone' directory to the 'node' user
RUN addgroup -S node && adduser -S -G node node

# Create necessary directories for application configuration with proper permissions
RUN mkdir -p /labone/etc/todos && chown -R node:node /labone/etc

# Copy only the package.json and package-lock.json to leverage Docker cache
COPY --chown=node:node package*.json ./

# Install Node.js packages using npm
RUN npm ci --only=production

# Copy the rest of the application files
COPY --chown=node:node . .

# Expose port 3000 for incoming connections
EXPOSE 3000

# Set the default command to start the application
CMD ["node", "src/index.js"]
