all:
	@echo "127.0.0.1 tauer.42.fr" | sudo tee -a /etc/hosts && echo "successfully added tauer.42.fr to /etc/hosts"
	sudo docker compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v
#	uncomment the following line to remove the images too
#	sudo docker system prune -a

fclean: clean
	@sudo sed -i '/127.0.0.1 tauer.42.fr/d' /etc/hosts && echo "successfully removed tauer.42.fr from /etc/hosts"	
	@if [ -d "/home/tauer/data/wordpress" ]; then \
	sudo rm -rf /home/tauer/data/wordpress/* && \
	echo "successfully removed all contents from /home/tauer/data/wordpress/"; \
	fi;

	@if [ -d "/home/tauer/data/mariadb" ]; then \
	sudo rm -rf /home/tauer/data/mariadb/* && \
	echo "successfully removed all contents from /home/tauer/data/mariadb/"; \
	fi;

re: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls