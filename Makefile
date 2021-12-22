reboot:
	docker system prune -f
	docker-compose down
	docker-compose build
	docker-compose up

in:
	docker exec -it task-management /bin/bash

migration:
	docker exec -it task-management rails db:create
	docker exec -it task-management rails db:migrate
	docker exec -it task-management rails db:seed

test:
	docker exec -it task-management rails test
	docker exec -it task-management rails test:system