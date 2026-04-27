x-base: &base
  image: chatwoot/chatwoot:{{ app_version | default:"v3.16.0" }}
  env_file: .env
  restart: always
  volumes:
    - storage_data:/app/storage

services:
  rails:
    <<: *base
    container_name: chatwoot-rails-{{ site_name }}
    depends_on:
      - postgres
      - redis
    ports:
      - '127.0.0.1:{{ ports.rails }}:3000'
    environment:
      - NODE_ENV=production
      - RAILS_ENV=production
      - INSTALLATION_ENV=docker
    entrypoint: docker/entrypoints/rails.sh
    command: ['bundle', 'exec', 'rails', 's', '-p', '3000', '-b', '0.0.0.0']
    networks:
      - {{ network_name | default:"xcloud-network" }}

  sidekiq:
    <<: *base
    container_name: chatwoot-sidekiq-{{ site_name }}
    depends_on:
      - postgres
      - redis
    environment:
      - NODE_ENV=production
      - RAILS_ENV=production
      - INSTALLATION_ENV=docker
    command: ['bundle', 'exec', 'sidekiq', '-C', 'config/sidekiq.yml']
    networks:
      - {{ network_name | default:"xcloud-network" }}

  postgres:
    image: pgvector/pgvector:pg16
    container_name: chatwoot-postgres-{{ site_name }}
    restart: always
    environment:
      - POSTGRES_DB=chatwoot
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD={{ _generated.postgres_password }}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - {{ network_name | default:"xcloud-network" }}

  redis:
    image: redis:alpine
    container_name: chatwoot-redis-{{ site_name }}
    restart: always
    command: 'redis-server --requirepass {{ _generated.redis_password }}'
    volumes:
      - redis_data:/data
    networks:
      - {{ network_name | default:"xcloud-network" }}

volumes:
  storage_data:
  postgres_data:
  redis_data:

networks:
  {{ network_name | default:"xcloud-network" }}:
    external: true
