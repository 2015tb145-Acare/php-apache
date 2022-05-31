.PHONY = all build publish update

all: build

update:
	./update.sh

build:
	$(update)
	docker buildx build --push --platform linux/arm64/v8,linux/amd64 --no-cache -t acare/php-apache:8.1 --no-cache -t acare/php-apache:latest 8.1
	docker buildx build --push --platform linux/arm64/v8,linux/amd64 --no-cache -t acare/php-apache:8.1-symfony 8.1-symfony
	docker buildx build --push --platform linux/arm64/v8,linux/amd64 --no-cache -t acare/php-apache:8.0 8.0
	docker buildx build --push --platform linux/arm64/v8,linux/amd64 --no-cache -t acare/php-apache:8.0-symfony 8.0-symfony
	docker buildx build --push --platform linux/arm64/v8,linux/amd64 --no-cache -t acare/php-apache:7.4 7.4
	docker buildx build --push --platform linux/arm64/v8,linux/amd64 --no-cache -t acare/php-apache:7.4-symfony 7.4-symfony

publish:
	docker push acare/php-apache --all-tags
