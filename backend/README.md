# Inventory API

Spring Boot 3.4.2 REST API using Java 21, Maven, Spring Security, JWT, MySQL, and Flyway.

## Run locally

From this directory, provide `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, and `JWT_SECRET` in your environment, then run:

- macOS/Linux/Git Bash: `./mvnw spring-boot:run`
- Windows PowerShell: `./mvnw.cmd spring-boot:run`

The default API port is 8080. When using Docker Compose from the repository root, the API is exposed on port 8081.

Set `LOW_STOCK_THRESHOLD` to change the number of units below which a product appears on the dashboard's low-stock list. It defaults to 10.

Flyway migrations are located in `src/main/resources/db/migration`. Hibernate validates the mapped schema at startup.
