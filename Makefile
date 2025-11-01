MKDIR := mkdir -p
D := docker
DC := docker compose

up: | data_dir
	cd srcs && $(DC) up --remove-orphans --build --detach --force-recreate && $(DC) logs -f
down: | data_dir
	cd srcs && $(DC) down --remove-orphans && $(DC) logs -f
clean: | data_dir
	$(D) run --workdir="/mnt/" --volume="$$HOME/data/:/mnt/" --rm alpine sh -c 'rm -rf *'
init_env:
	env -i sh -c $$'env | sort > srcs/.env; set -a; . srcs/.env.template; sort << EOF | comm -13 srcs/.env - | sed \'s/["\\]/\\\\&/g; s/=/="/; s/$$/"/\' | { sleep .1; >/dev/null tee srcs/.env; }\n$$(env)\nEOF'
re: clean init_env
	$(MAKE) down
	$(MAKE) up
data_dir:
	$(MKDIR) -p -- "$$HOME/data/wp_db" "$$HOME/data/wp_site"

.PHONY: up down clean re data_dir
