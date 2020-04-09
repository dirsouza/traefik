# Desenvolvimento
FROM node:12.16.1-alpine3.9 AS development

WORKDIR /usr/app

COPY package*.json ./

RUN npm install

COPY . .

# Build do projeto
FROM development AS build

RUN npm run build

# Produção
FROM nginx:1.17-alpine AS production

COPY --from=build /usr/app/dist /var/www

RUN rm /etc/nginx/conf.d/default.conf

COPY ../nginx/front/default.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
