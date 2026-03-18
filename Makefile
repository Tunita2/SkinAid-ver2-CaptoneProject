dev:
	docker compose up --build

down:
	docker compose down

migrate:
	docker compose exec api alembic upgrade head

logs:
	docker compose logs -f api

shell:
	docker compose exec api bash
