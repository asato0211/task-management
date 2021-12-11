reboot:
	docker system prune -f
	docker-compose down
	docker-compose build
	docker-compose up

in:
	docker exec -it web /bin/bash

migration:
	docker exec -it web rails db:create
	docker exec -it web rails db:migrate
	docker exec -it web rails db:seed