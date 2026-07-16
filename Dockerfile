FROM node:20-alpine

# Install curl for container health check
RUN apk add --no-cache curl

# Create app directory
WORKDIR /app

# Copy package files first for layer caching
COPY package*.json ./

# Install production dependencies only
RUN npm install --omit=dev

# Copy all application source files
COPY server.js ./
COPY src/ ./src/
COPY public/ ./public/

# Create public directory if it doesn't exist (optional static dir)
RUN mkdir -p public

EXPOSE 3000

CMD ["npm", "start"]