# Use Node.js 20 based on Debian Bullseye (compatible with Ubuntu/Debian)
FROM node:20-bullseye

# Define build argument for the Better Stack token (injected by Railway)
ARG BETTER_STACK_TOKEN

# Install curl for Vector setup
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set working directory for Express app
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install Node.js dependencies with frozen lockfile
RUN npm install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Expose port 8080
EXPOSE 8080

# Build the application (optional, no-op for simple Express apps)
RUN npm run build

# Start Vector in the background and the Express service
CMD npm start
