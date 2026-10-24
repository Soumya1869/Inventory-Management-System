# Inventory Management System

A Spring Boot 3.4.2 inventory API built with Java 21, Spring Security, JWT, MySQL, and Docker Compose.

## Prerequisites

- Docker and Docker Compose
- Java 21 and Maven (for running outside Docker)
- OpenSSL (to generate a JWT signing key)

## Run with Docker

1. Copy the example environment file and replace the placeholders:

   **macOS/Linux/Git Bash**
   ```bash
   cp .env.example .env
   ```

   **Windows PowerShell**
   ```powershell
   Copy-Item .env.example .env
   ```

2. Generate a fresh JWT signing key and place its output in `JWT_SECRET` in `.env`:

   ```bash
   openssl rand -base64 64
   ```

   Set unique strong values for `MYSQL_ROOT_PASSWORD` and `DB_PASSWORD` too. Do not commit `.env`. If you used a previously published password anywhere, rotate it.

3. Start the application:

   ```bash
   docker compose up -d --build
   ```

4. Check the application log:

   ```bash
   docker logs -f inventory-app
   ```

- API: `http://localhost:8081`
- MySQL: `localhost:3307`

Stop the application with `docker compose down`.

## Database migrations

Flyway applies versioned SQL from `src/main/resources/db/migration` at startup. A fresh database receives the initial schema from `V1__create_inventory_schema.sql`. Hibernate uses `validate` and fails startup if the database does not match the entity mappings; it no longer creates or alters tables automatically.

For a non-empty database without Flyway history, Flyway baselines it at version 1 and Hibernate validates it. Back up an existing database before upgrading. If validation fails, stop and reconcile the existing schema with the JPA model before retrying. The checked-in `db.sql` is a legacy export for a different schema and is not used for application setup.

## Run locally

Provide `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, and `JWT_SECRET` in your environment, then run:

```bash
./mvnw spring-boot:run
```

## Authentication

- Register: `POST /auth/register`
- Login: `POST /auth/login` (returns a JWT)
- Send `Authorization: Bearer <token>` to protected endpoints.

Registration accepts only profile fields; it does not accept role assignments or persistence metadata. Passwords must contain at least 12 characters. The registration response omits the password.
