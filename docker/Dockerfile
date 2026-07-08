# Custom Chatwoot Image - Megapisos
# Baseado na imagem oficial do Chatwoot já compilada
# Isso evita compilar todas as gems nativas do zero (que leva 1+ hora em Alpine)
FROM chatwoot/chatwoot:v4.15.1

# Copia todo o código-fonte customizado por cima da imagem oficial
COPY . /app

# Instala nodejs e npm via apk para permitir a compilação dos assets
RUN apk update && apk add --no-cache nodejs npm

# Define variáveis de ambiente necessárias para a compilação dos assets
ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV SECRET_KEY_BASE=precompile_placeholder
ENV NODE_OPTIONS="--max-old-space-size=4096 --openssl-legacy-provider"

# Instala pnpm globalmente, instala dependências e compila assets
RUN npm install -g pnpm@10.2.0
RUN pnpm install --frozen-lockfile
RUN bundle exec rails assets:precompile

# Limpa o cache e remove nodejs/npm instalados temporariamente
RUN rm -rf node_modules tmp/cache && apk del nodejs npm

EXPOSE 3000
