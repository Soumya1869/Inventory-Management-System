# Stockroom frontend

This folder contains the first frontend screen: a responsive sign-in page for the inventory API.

## Requirements

- Node.js 20.19+ (or 22.12+)
- The Spring Boot API running at `http://localhost:8081`

## Run locally

```bash
npm install
npm run dev
```

Open the local URL printed by Vite. Login requests are sent to `/api/auth/login` and proxied to the Spring API. The request uses the API's `username` and `password` fields; the returned `jwtToken` is kept in `sessionStorage` for the current browser tab.

To proxy to a different API URL, copy `.env.example` to `.env.local` and change `API_PROXY_TARGET`. Keep `.env.local` out of Git.
\n\n## Inventory dashboard\n\nAfter signing in, the dashboard loads product and stock summaries from the authenticated `GET /dashboard/summary` endpoint. Stock quantities are summed across stock records. Products with fewer than 10 units are flagged as low stock by default; configure `LOW_STOCK_THRESHOLD` on the API to change that value.\n