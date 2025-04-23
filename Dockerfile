# Stage 1: Build the Angular app
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

# Stage 2: Serve app with http-server
FROM node:18-alpine

RUN npm install -g http-server

WORKDIR /app

# Replace this with your actual build output folder name
COPY --from=builder /app/dist/angular-github-actions-amazon-s3 ./

EXPOSE 8080

CMD ["http-server", "-p", "8080"]
