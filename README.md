# python-uv-template

Template for python projects managed by uv

## Usage

Most likely you already have `uv` installed, to create a repo from the template run:

```sh
uvx copier copy gh:vladserkoff/python-uv-template path/to/new/project
```

Then `cd` to the project directory, initialize a repo and enable `pre-commit` hooks:
```sh
make init
```

## Notes

It comes with generic instructions for claude code which might not work for you. You can disable it by refusing it during project creation.
