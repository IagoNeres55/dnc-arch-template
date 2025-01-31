# FROM node:20-alpine

# WORKDIR /app

# COPY package.json .

# # RUN npm config set strict-ssl false

# RUN npm install

# RUN npm i -g serve

# COPY . .

# RUN npm run build 

# EXPOSE 3000

# CMD ["npx", "vite", "preview", "--host", "0.0.0.0", "--port", "3000"]
# CMD ["serve", "-s", "dist"]


# ________________________________________________________________

# Etapa 1: Build
FROM node:18-alpine AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de configuração do projeto
COPY package.json package-lock.json ./

# Instala as dependências
RUN npm install

# Copia o restante do código do projeto
COPY . .

# Constrói o projeto
RUN npm run build

# Etapa 2: Produção
FROM nginx:alpine

# Copia os arquivos construídos para o NGINX
COPY --from=build /app/dist /usr/share/nginx/html

# Exposição da porta do NGINX
EXPOSE 80

# Inicializa o NGINX
CMD ["nginx", "-g", "daemon off;"]
