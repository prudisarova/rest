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

# Install and configure Vector using the token from the ARG (Railway env var)
RUN curl -sSL https://telemetry.betterstack.com/setup-vector/docker/${BETTER_STACK_TOKEN} -o /tmp/setup-vector.sh && \
    bash /tmp/setup-vector.sh && \
    rm /tmp/setup-vector.sh

# Grant Vector permissions to access Docker logs (if needed in Railway context)
RUN usermod -a -G docker vector || true

# Expose port 8080
EXPOSE 8080

# Build the application (optional, no-op for simple Express apps)
RUN npm run build

# Start Vector in the background and the Express service
CMD service vector start && npm start
