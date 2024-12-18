FROM node:16

# Establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar archivos de configuración
COPY package.json ./

# Instalar dependencias
RUN npm install --legacy-peer-deps

# Eliminar archivos de lock y compilar dependencias Angular
RUN rm -f /usr/src/app/node_modules/.ngcc_lock_file || true
RUN npx ngcc --properties es2015 browser module main --first-only --create-ivy-entry-points || echo "Skipping ngcc"

# Copiar el resto del proyecto
COPY . .

# Exponer puerto para Angular
EXPOSE 4200

# Script para manejar el lock y correr la aplicación
CMD ["sh", "-c", "rm -f /usr/src/app/node_modules/.ngcc_lock_file && npm start"]
