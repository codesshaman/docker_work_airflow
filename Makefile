name = airflow

NO_COLOR=\033[0m		# Color Reset
COLOR_OFF='\e[0m'       # Color Off
OK_COLOR=\033[32;01m	# Green Ok
ERROR_COLOR=\033[31;01m	# Error red
WARN_COLOR=\033[33;01m	# Warning yellow
RED='\e[1;31m'          # Red
GREEN='\e[1;32m'        # Green
YELLOW='\e[1;33m'       # Yellow
BLUE='\e[1;34m'         # Blue
PURPLE='\e[1;35m'       # Purple
CYAN='\e[1;36m'         # Cyan
WHITE='\e[1;37m'        # White
UCYAN='\e[4;36m'        # Cyan

all:
	@printf "Запуск конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yaml up -d

build:
	@printf "Сборка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yaml up -d --build

help:
	@echo -e "$(OK_COLOR)==== All commands of ${name} configuration ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- make				: Запуск конфигурации"
	@echo -e "$(WARN_COLOR)- make build			: Сборка конфигурации"
	@echo -e "$(WARN_COLOR)- make down			: Остановка конфигурации"
	@echo -e "$(WARN_COLOR)- make ps			: Обзор конфигурации"
	@echo -e "$(WARN_COLOR)- make re			: Перезапуск конфигурации"
	@echo -e "$(WARN_COLOR)- make clean			: Очистка конфигурации"
	@echo -e "$(WARN_COLOR)- make fclean			: Очистка кеша docker$(NO_COLOR)"

down:
	@printf "Остановка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yaml down

ps:
	@docker-compose -f ./docker-compose.yaml ps

re:
	@printf "Пересборка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yaml down
	@docker-compose -f ./docker-compose.yaml up -d --build

clean: down
	@printf "Очистка конфигурации ${name}...\n"
	@docker system prune --a

fclean:
	@printf "Полная очистка всех конфигураций docker\n"
#	@docker stop $$(docker ps -qa)
#	@docker system prune --all --force --volumes
#	@docker network prune --force
#	@docker volume prune --force

.PHONY	: all build down ps re clean fclean