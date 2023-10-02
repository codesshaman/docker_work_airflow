name = airflow

VAR :=				# Cmd arg var
NO_COLOR=\033[0m	# Color Reset
OK=\033[32;01m		# Green Ok
ERROR=\033[31;01m	# Error red
WARN=\033[33;01m	# Warning yellow

all:
	@printf "Запуск конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d

help:
	@echo -e "$(OK)==== Все команды для конфигурации ${name} ===="
	@echo -e "$(WARN)- make				: Запуск конфигурации"
	@echo -e "$(WARN)- make cli			: Пересканирование переменных"
	@echo -e "$(WARN)- make build			: Сборка конфигурации"
	@echo -e "$(WARN)- make dags			: Пересканирование дагов"
	@echo -e "$(WARN)- make down			: Остановка конфигурации"
	@echo -e "$(WARN)- make downws			: Остановка airflow-webserver"
	@echo -e "$(WARN)- make init			: Инициализация конфигурации"
	@echo -e "$(WARN)- make local			: Экспорт локальной переменной"
	@echo -e "$(WARN)- make localbuild		: Локальная эмуляция билда"
	@echo -e "$(WARN)- make ps			: Обзор запущенной конфигурации"
	@echo -e "$(WARN)- make push			: Пуш с билдом для запуска ci/cd"
	@echo -e "$(WARN)- make re			: Перезапуск конфигурации"
	@echo -e "$(WARN)- make scan			: Поиск изменений переменных"
	@echo -e "$(WARN)- make show			: Логирование изменений"
	@echo -e "$(WARN)- make tag			: Показать тег последнего образа"
	@echo -e "$(WARN)- make up			: Первый запуск конфигурации"
	@echo -e "$(WARN)- make clean			: Очистка конфигурации"
	@echo -e "$(WARN)- make fclean			: Очистка кеша docker"
	@echo -e "$(OK)==== ВНИМАНИЕ! ВАЖНО ===="
	@echo -e "$(WARN)- Для экспорта переменных используем"
	@echo -e "$(WARN)- сначала команду make scan, затем make cli!"
	@echo -e "$(WARN)- При первом запуске конфигурации используем"
	@echo -e "$(WARN)- сначала команду make init, затем make up!$(NO_COLOR)"

build:
	@printf "Сборка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d --build

cli:
	@printf "Пересканирование всех переменных ${name}...\n"
	@bash ./scripts/varimport.sh

dags: .dags_marker
	@printf "Пересканирование всех дагов ${name}...\n"
	@docker-compose -f ./docker-compose.yml restart airflow-scheduler airflow-webserver

.dags_marker:
	@touch $@

down:
	@printf "Остановка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml down

downws:
	@printf "Остановка airflow-webserver...\n"
	@docker-compose -f ./docker-compose.yml stop airflow-webserver

init:
	@printf "Инициализации конфигурации ${name}...\n"
	@bash ./scripts/init.sh
	@docker-compose up airflow-init

local:
	@printf "Инициализации конфигурации ${name}...\n"
	@bash ./scripts/local.sh

localbuild:
	@printf "Инициализация конфигурации ${name}...\n"
	@bash ./scripts/localbuild.sh

ps:
	@docker-compose -f ./docker-compose.yml ps

push:
	@bash ./scripts/push.sh

re:
	@printf "Пересборка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml down
	@docker-compose -f ./docker-compose.yml up -d --build

scan:
	@printf "$(WARN_COLOR)==== Проверяю изменения в переменных ${name}... ====$(NO_COLOR)\n"
	@bash ./scripts/scan.sh

show:
	@printf "$(WARN_COLOR)==== Заношу изменения в файл ${name}... ====$(NO_COLOR)\n"
	@bash ./scripts/all_vars.sh > .variables

tag:
	@bash ./scripts/tag.sh

up:
	@printf "Первый запуск конфигурации ${name}...\n"
	@docker-compose up -d

clean: down
	@printf "Очистка конфигурации ${name}...\n"
	@docker system prune -a

fclean:
	@printf "Полная очистка всех конфигураций docker\n"
#	@docker stop $$(docker ps -qa)
#	@docker system prune --all --force --volumes
#	@docker network prune --force
#	@docker volume prune --force

.PHONY	: all build down ps re scan show clean fclean
