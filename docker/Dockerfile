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

# 4. Logo customizada no painel (Logo.vue)
COPY app/javascript/dashboard/components-next/icon/Logo.vue /app/app/javascript/dashboard/components-next/icon/Logo.vue

# 5. Logo nas views do super admin e onboarding
COPY app/views/super_admin/devise/sessions/new.html.erb /app/app/views/super_admin/devise/sessions/new.html.erb
COPY app/views/installation/onboarding/index.html.erb /app/app/views/installation/onboarding/index.html.erb
COPY app/views/super_admin/application/_navigation.html.erb /app/app/views/super_admin/application/_navigation.html.erb

EXPOSE 3000
