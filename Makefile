up:
	cd srcs && docker compose up --remove-orphans --detach --force-recreate && docker compose logs -f
down:
	cd srcs && docker compose down --remove-orphans && docker compose logs -f
clean:
	$(RM) -r -- "$$HOME/data"
re: clean
	$(MAKE) down
	$(MAKE) up
