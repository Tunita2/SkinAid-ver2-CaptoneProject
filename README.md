# SkinAid CAP2

Shared development workspace for SkinAid backend and AI modules.

## Project Structure

```text
skinaid/
├── backend/
│   ├── app/
│   │   ├── routers/
│   │   ├── services/
│   │   ├── models/
│   │   ├── schemas/
│   │   ├── utils/
│   │   └── main.py
│   ├── alembic/
│   ├── tests/
│   ├── requirements.txt
│   └── Dockerfile
├── ai/
│   ├── models/
│   ├── checkpoints/
│   ├── data/
│   ├── scripts/
│   ├── inference.py
│   └── requirements_ai.txt
├── mobile/
├── docker-compose.yml
├── .env.example
├── Makefile
└── README.md
```

## Quick Start (under 5 minutes)

### 1) Prepare env file

Linux/macOS:

```bash
cp .env.example .env
```

Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

### 2) Start all services

Preferred (Makefile):

```bash
make dev
```

Alternative:

```bash
docker compose up --build
```

### 3) Health check

Open this URL after containers are up:

```text
http://localhost:8000/health
```

Expected response:

```json
{"status":"ok","db":"ok","redis":"ok"}
```

## Useful Commands

```bash
make dev      # docker compose up --build
make down     # docker compose down
make migrate  # run alembic upgrade head in api container
make logs     # follow api logs
make shell    # open shell inside api container
```

## Notes

- Do not commit secrets. Keep real credentials in .env only.
- Large model files should not be committed directly to git.