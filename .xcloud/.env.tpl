# Chatwoot configuration — generated at install time, do not commit.

# --- Rails / security ---
SECRET_KEY_BASE={{ _generated.secret_key_base }}
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY={{ _generated.active_record_encryption_primary_key }}
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY={{ _generated.active_record_encryption_deterministic_key }}
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT={{ _generated.active_record_encryption_key_derivation_salt }}

# --- Application ---
FRONTEND_URL=https://{{ domain }}
DEFAULT_LOCALE=en
FORCE_SSL=true
ENABLE_ACCOUNT_SIGNUP=true
RAILS_ENV=production
RAILS_MAX_THREADS={{ resources.rails_max_threads | default:"5" }}
RAILS_LOG_TO_STDOUT=true
LOG_LEVEL=info

# --- Database (PostgreSQL with pgvector) ---
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD={{ _generated.postgres_password }}
POSTGRES_DATABASE=chatwoot
POSTGRES_STATEMENT_TIMEOUT=14s

# --- Redis ---
REDIS_URL=redis://:{{ _generated.redis_password }}@redis:6379
REDIS_PASSWORD={{ _generated.redis_password }}

# --- Sidekiq ---
SIDEKIQ_CONCURRENCY={{ resources.sidekiq_concurrency | default:"10" }}

# --- Outbound email (optional — fill in to enable transactional emails) ---
MAILER_SENDER_EMAIL={{ smtp_sender_email | default:"" }}
SMTP_DOMAIN={{ smtp_host | default:"" }}
SMTP_ADDRESS={{ smtp_host | default:"" }}
SMTP_PORT={{ smtp_port | default:"587" }}
SMTP_USERNAME={{ smtp_username | default:"" }}
SMTP_PASSWORD={{ smtp_password | default:"" }}
SMTP_AUTHENTICATION=login
SMTP_ENABLE_STARTTLS_AUTO=true
SMTP_OPENSSL_VERIFY_MODE=peer

# --- Storage (local by default; switch to S3 by editing this file post-install) ---
ACTIVE_STORAGE_SERVICE=local

# --- Admin email (used for first-account hint and system notices) ---
DEFAULT_ADMIN_EMAIL={{ admin_email }}
