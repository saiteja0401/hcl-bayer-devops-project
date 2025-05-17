# First we build the app with dependencies
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY patient-service.js .

# Finally we create the lightweight image 
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["node", "patient-service.js"]