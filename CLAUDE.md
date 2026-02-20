# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A [copier](https://copier.readthedocs.io/) template that scaffolds opinionated Python projects using `uv`. To generate a new project from it:

```bash
uvx copier copy gh:vladserkoff/python-uv-template path/to/new/project
# or locally:
uvx copier copy . path/to/test-output
```

## Key conventions

### Two layers of files

Everything in the repo is either:

1. **Template machinery** — `copier.yml`, `pyproject.toml`, `README.md`, `.pre-commit-config.yaml`: config for this repo itself, not rendered into generated projects.
2. **Template files** (`.jinja` suffix) — rendered by copier into the generated project. All Jinja2 expressions refer to variables defined in `copier.yml`.

### Copier filename templating

Conditional output filenames use the pattern `{% if var %}real-name{% endif %}.jinja`:

- `{% if include_claude_code %}CLAUDE.md{% endif %}.jinja` → emits `CLAUDE.md` only when `include_claude_code=true`
- `{% if include_claude_code %}.claude{% endif %}/settings.local.json` → the directory name itself is conditional
- `{% if include_docker %}Dockerfile{% endif %}.jinja` → same pattern for Docker files

### Template variables (`copier.yml`)

| Variable | Type | Default |
|---|---|---|
| `project_name` | str | _(required)_ |
| `project_description` | str | `""` |
| `python_version` | str | `"3.13"` |
| `version` | str | `"0.0.1"` |
| `include_claude_code` | bool | `true` |
| `include_docker` | bool | `false` |

## What the template generates

- `pyproject.toml` — uv project with ruff (linting + formatting), ty (type checking), pytest; dependencies: loguru, rich, typer, pydantic
- `Makefile` — `make init` (git + pre-commit setup), `make lint`, `make lint-unsafe`
- `.pre-commit-config.yaml` — ruff, prettier, pyproject-fmt, add-trailing-comma; hook revisions are left blank and pinned by `pre-commit autoupdate` during `make init`
- `src/{{ project_name }}/__init__.py`
- `CLAUDE.md` + `.claude/settings.local.json` (if `include_claude_code`)
- `Dockerfile` + `.dockerignore` (if `include_docker`)

## Development

This repo has no Python source to lint. Pre-commit here runs only prettier (markdown/yaml) and whitespace fixers:

```bash
uv run pre-commit run --all-files   # lint template files (yaml, markdown)
```

When editing `.pre-commit-config.yaml.jinja`, leave `rev: ''` — the blank revisions are intentional; `make init` calls `pre-commit autoupdate` in the generated project to fill them in.
