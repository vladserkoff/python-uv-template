.PHONY: init
init:
	git init
	uv run pre-commit autoupdate # set the version of the hooks to pre-commit config
	uv run pre-commit install # install pre-commit hooks that run linting and tests on commits
