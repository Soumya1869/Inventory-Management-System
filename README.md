# Inventory Management System

A full-stack inventory management application with a Spring Boot API and a React frontend.

## Project structure

- `backend/` — Spring Boot 3.4.2 API, Java 21, Maven, Spring Security, JWT, MySQL, and Flyway.
- `frontend/` — React, TypeScript, and Vite sign-in page and inventory dashboard.
- `docker-compose.yml` — runs the API and MySQL from the repository root.

## Prerequisites

- Docker and Docker Compose
- Node.js 20.19+ (or 22.12+) for the frontend
- Java 21 (for running the backend outside Docker)
- OpenSSL to generate a JWT signing key

## Run with Docker

1. Copy `.env.example` to `.env` and replace the placeholders. Set unique strong values for `MYSQL_ROOT_PASSWORD` and `DB_PASSWORD`; do not commit `.env`.

   PowerShell:
   ```powershell
   Copy-Item .env.example .env
   ```

   macOS/Linux/Git Bash:
   ```bash
   cp .env.example .env
   ```

2. Generate a signing key with `openssl rand -base64 64` and place it in `JWT_SECRET`.

3. Start both services from the repository root:
   ```bash
   docker compose up -d --build
   ```

The API is available at `http://localhost:8081`; MySQL is available at `localhost:3307`. Stop the services with `docker compose down`.

## Run locally

See [backend/README.md](backend/README.md) for running the API and [frontend/README.md](frontend/README.md) for the UI. Start the API on port 8081 for the Vite development proxy, or update `frontend/.env.local` to use another API URL.

## Database migrations

Flyway migrations are in `backend/src/main/resources/db/migration`. Hibernate validates the schema at startup and does not create or alter tables automatically. The checked-in `backend/db.sql` is a legacy export for a different schema and is not used for application setup.

## Authentication

- Register: `POST /auth/register`
- Login: `POST /auth/login` (returns a JWT)
- Protected API requests require `Authorization: Bearer <token>`.

Registration accepts profile fields only, does not accept role assignments or persistence metadata, requires passwords of at least 12 characters, and omits the password from its response.
