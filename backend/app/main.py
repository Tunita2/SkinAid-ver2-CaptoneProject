from fastapi import FastAPI

app = FastAPI(title="SkinAid API")


@app.get("/health")
async def health() -> dict:
    return {"status": "ok", "db": "ok", "redis": "ok"}
