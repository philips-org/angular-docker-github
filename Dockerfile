# Stage 1: Build the Angular app
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve app with Nginx
FROM nginx:alpine

# Replace this with your actual build output folder name
COPY --from=builder /app/dist/angular-aws-s3 /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
