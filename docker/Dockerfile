# Baseado na imagem oficial do Chatwoot já compilada
# Isso evita compilar todas as gems nativas do zero (que leva 1+ hora em Alpine)
FROM chatwoot/chatwoot:v4.15.1

# Copia apenas os arquivos customizados por cima da imagem oficial
# 1. Policy de visibilidade de conversas (apenas conversas atribuídas ao agente)
COPY app/policies/conversation_policy.rb /app/app/policies/conversation_policy.rb

# 2. Filtro de listagem de conversas (por assignee/time)
COPY app/services/conversations/permission_filter_service.rb /app/app/services/conversations/permission_filter_service.rb

# 3. Filtro de busca global (search service)
COPY app/services/search_service.rb /app/app/services/search_service.rb

# 4. Logo customizada no painel (Logo.vue) and Sidebar
COPY app/javascript/dashboard/components-next/icon/Logo.vue /app/app/javascript/dashboard/components-next/icon/Logo.vue
COPY app/javascript/dashboard/components-next/sidebar/Sidebar.vue /app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue

# 5. Logo nas views do super admin e onboarding
COPY app/views/super_admin/devise/sessions/new.html.erb /app/app/views/super_admin/devise/sessions/new.html.erb
COPY app/views/installation/onboarding/index.html.erb /app/app/views/installation/onboarding/index.html.erb
COPY app/views/super_admin/application/_navigation.html.erb /app/app/views/super_admin/application/_navigation.html.erb

# 6. Controllers customizados para permissões e restrição de atribuição
COPY app/controllers/api/v1/accounts/conversations/assignments_controller.rb /app/app/controllers/api/v1/accounts/conversations/assignments_controller.rb
COPY app/controllers/api/v1/accounts/conversations_controller.rb /app/app/controllers/api/v1/accounts/conversations_controller.rb

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
