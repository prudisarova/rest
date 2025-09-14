# Use Node.js 20 as the base image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Expose port 8080
EXPOSE 8080

# Start the Express service
CMD ["npm", "start"]