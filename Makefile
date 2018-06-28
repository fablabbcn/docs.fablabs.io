PWD=`pwd`

DOCS_DOCKER_OPTS=run --rm -i -t -v $(PWD)/mkdocs:/mkdocs -v $(PWD)/dist:/dist
DOCS_DOCKER_IMG=fibasile/mkdocs:latest
DOCS_DOCKER_CMD=build -f /mkdocs/mkdocs.yml --site-dir /dist
DOCS_SERVE_CMD=serve -f /mkdocs/mkdocs.yml -a 0.0.0.0:8000
DOCS_PORTMAP=-p 8000:8000
SWAGGER_URL=https://raw.githubusercontent.com/fablabbcn/fablabs.io/master/swagger.json
SWAGGER_IMG=swaggerapi/swagger-codegen-cli
SWAGGER_DOCKER_OPTS= run --rm -v $(PWD):/local
SWAGGER_CMD=generate -i $(SWAGGER_URL) -l html2 -o /local/dist/swagger


all: docs swagger

ghpages: docs swagger
	git subtree push --prefix dist origin gh-pages

deploy: docs swagger
	now --public

docs:
	docker $(DOCS_DOCKER_OPTS) $(DOCS_DOCKER_IMG) $(DOCS_DOCKER_CMD)

swagger: docs
	docker $(SWAGGER_DOCKER_OPTS) $(SWAGGER_IMG) $(SWAGGER_CMD)

dev:
	docker  $(DOCS_DOCKER_OPTS) $(DOCS_PORTMAP) $(DOCS_DOCKER_IMG) $(DOCS_SERVE_CMD)
