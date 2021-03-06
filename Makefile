SRC_FILES := $(shell find src -name '*.ts')

all: lib

lib: $(SRC_FILES) node_modules tsconfig.json
	./node_modules/.bin/tsc -p tsconfig.json --outDir lib
	touch lib

.PHONY: lint
lint: node_modules
	NODE_ENV=test ./node_modules/.bin/tslint -p tsconfig.json -c tslint.json -t stylish --fix

node_modules:
	yarn install --non-interactive --frozen-lockfile

.PHONY: clean
clean:
	rm -rf lib/

.PHONY: distclean
distclean: clean
	rm -rf node_modules/
