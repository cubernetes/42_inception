MKDIR := mkdir -p
D := docker
DC := docker compose

ENV := srcs/.env
ENV_TEMPLATE := srcs/.env.template

export ENV ENV_TEMPLATE

up: | data_dir $(ENV)
	cd srcs && $(DC) up --remove-orphans --build --detach --force-recreate && $(DC) logs -f
down: | data_dir $(ENV)
	cd srcs && $(DC) down --remove-orphans && $(DC) logs -f
clean: | data_dir
	$(D) run --workdir="/mnt/" --volume="$$HOME/data/:/mnt/" --rm alpine sh -c 'rm -rf *'
re: clean $(ENV)
	$(MAKE) down
	$(MAKE) up

data_dir:
	$(MKDIR) -p -- "$$HOME/data/wp_db" "$$HOME/data/wp_site"

$(ENV): $(ENV_TEMPLATE)
	@# Render env template. Works with multiline variables as well. Requires the `-z` option to sed.
	env -i sh -c 'quote () { sed -z '\''s/\n[a-zA-Z_][a-zA-Z0-9_]*=/&"/g; s/\n[a-zA-Z_][a-zA-Z0-9_]*="/"&/g; s/^[a-zA-Z_][a-zA-Z0-9_]*=/&"/; s/\n$$/"\n/g'\''; } && env | quote > "$$ENV" && set -- && while LC_ALL=C IFS= read -r line; do set -- "$$@" -e "$$line"; done < "$$ENV" && set -a && . "$$ENV_TEMPLATE" && env | quote | grep -vFx "$$@" | { sleep .1 && >/dev/null tee "$$ENV"; }'

.PHONY: up down clean re data_dir
