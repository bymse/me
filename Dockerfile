FROM node:20-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

# Copy the entire project to the container
COPY . .

RUN npx eleventy

FROM nginx:latest

COPY --from=builder /app/_site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]