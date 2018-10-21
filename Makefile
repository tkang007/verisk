
PACKAGE := verisk
VERSION := $(shell python -c "import version; print(version.__version__)" )

info:
	@echo "Package: $(PACKAGE), Version: $(VERSION)"

install-tools:
	conda install --yes --quiet  nose flake8 autopep8 twine

lint:
	flake8 --max-line-length 120 .

format:
	autopep8 --in-place --max-line-length 120 *.py 

test:
	nosetests .

clean:
	rm -rf build dist

build: clean
	python setup.py build

dist: clean
	python setup.py sdist 


upload-test: dist
	twine upload --repository-url https://test.pypi.org/legacy/ dist/*

upload: dist
	twine upload dist/*
	

all: info lint format test dist upload-test

