
PACKAGE := verisk
VERSION := $(python -c 'import version; print(version.__version__)' )

info:
	@echo "Package: $PACKAGE, Version: $VERSION"

install-tools:
	conda install --yes --quiet  nose flake8 autopep8 twine

lint:
	flake8 .

format:
	autopep8 .

test:
	nosetests .

clean:
	rm -rf build dist

#build: clean
#	python setup.py build

dist: clean
	python setup.py sdist bdist_wheel


upload-test: 
	twine upload --config-file .pypirc  -r pypitest dist/*

upload: 
	#twine upload --repository-url https:/pypi.org/ dist/*
	twine upload --config-file .pypirc -r pypi dist/*


all: info lint format test dist upload-test





