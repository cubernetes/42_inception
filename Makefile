up:
	cd srcs && docker compose up --detach --force-recreate && docker compose logs -f
down:
	cd srcs && docker compose down --remove-orphans && docker compose logs -f
