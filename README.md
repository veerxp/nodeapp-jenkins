# 🚀 Node.js DevOps Project

A production-ready Node.js Express app with full DevOps automation: Docker, CI/CD, testing, and health checks.

## 📁 Project Structure

```
nodeapp/
├── src/
│   └── index.js          # Express app
├── tests/
│   └── app.test.js       # Jest tests
├── .github/
│   └── workflows/
│       └── ci-cd.yml     # GitHub Actions pipeline
├── Dockerfile            # Multi-stage Docker build
├── docker-compose.yml    # Local orchestration
├── Makefile              # Handy shortcuts
├── .dockerignore
├── .gitignore
└── .env.example
```

## 🛠️ Local Development

### Prerequisites
- [Node.js 20+](https://nodejs.org)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### 1. Install dependencies
```bash
npm install
```

### 2. Run locally (without Docker)
```bash
npm run dev        # hot-reload with nodemon
```

### 3. Run tests
```bash
npm test           # runs Jest + coverage report
```

## 🐳 Docker

### Build & run with Docker Compose
```bash
# Production mode
make up            # or: docker compose up -d

# Dev mode (hot-reload from host)
make dev-up        # or: docker compose --profile dev up -d app-dev redis
```

### Useful commands
```bash
make logs          # tail app logs
make shell         # open shell inside container
make down          # stop everything
make clean         # remove containers + images + volumes
```

## 🔗 Endpoints

| Method | URL           | Description          |
|--------|---------------|----------------------|
| GET    | `/`           | Welcome message      |
| GET    | `/health`     | Health check         |
| GET    | `/api/users`  | List users           |

## ⚙️ GitHub Actions CI/CD

The pipeline in `.github/workflows/ci-cd.yml` runs automatically:

| Step               | Trigger            | What it does                    |
|--------------------|--------------------|---------------------------------|
| 🧪 Test            | Every push / PR    | Runs Jest tests + coverage      |
| 🐳 Build           | After tests pass   | Builds Docker image, smoke test |
| 📦 Push to Hub     | Push to `main`     | Pushes image to Docker Hub      |

### Setup Docker Hub secrets (for push step)
In your GitHub repo → **Settings → Secrets → Actions**:
- `DOCKERHUB_USERNAME` — your Docker Hub username
- `DOCKERHUB_TOKEN`    — your Docker Hub access token

## 🌍 Environment Variables

Copy `.env.example` to `.env` and fill in:
```
NODE_ENV=development
PORT=3000
REDIS_URL=redis://localhost:6379
```
