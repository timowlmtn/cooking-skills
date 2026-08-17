PYTHON ?= python3
ENV_FILE ?= setenv.sh
BOOTSTRAP_SCRIPT := scripts/bootstrap_drive.py

.DEFAULT_GOAL := help

.PHONY: help install-deploy-deps check-python check-config dry-run deploy

help:
	@printf '%s\n' \
	  'CookingSkills ChatGPT app deployment' \
	  '' \
	  'make install-deploy-deps  Install the one-time Google Drive API dependencies.' \
	  'make dry-run              Show the Drive bootstrap plan without logging in or writing.' \
	  'make deploy               Sign in to Google and bootstrap both configured Drive folders.' \
	  '' \
	  'Configuration lives in setenv.sh (copy setenv.example.sh and keep it untracked).'

install-deploy-deps:
	$(PYTHON) -m pip install -r requirements-deploy.txt

check-python:
	@$(PYTHON) --version >/dev/null 2>&1 || { \
	  printf '%s\n' "Python interpreter '$(PYTHON)' is unavailable."; \
	  printf '%s\n' 'Install Python 3.10+ or rerun with PYTHON=/absolute/path/to/python3.'; \
	  exit 1; \
	}

check-config:
	@test -r "$(ENV_FILE)" || { \
	  printf '%s\n' 'Missing setenv.sh. Copy setenv.example.sh, then set the Drive URLs and Google OAuth client values.'; \
	  exit 1; \
	}
	@set -a; . "./$(ENV_FILE)"; set +a; \
	  test -n "$$REFERENCE_DRIVE_DIR" || { printf '%s\n' 'REFERENCE_DRIVE_DIR is required.'; exit 1; }; \
	  test -n "$$USER_DRIVE_DIR" || { printf '%s\n' 'USER_DRIVE_DIR is required.'; exit 1; }; \
	  test -n "$$GOOGLE_OAUTH_CLIENT_ID" || { printf '%s\n' 'GOOGLE_OAUTH_CLIENT_ID is required.'; exit 1; }; \
	  test -n "$$GOOGLE_OAUTH_CLIENT_SECRET" || { printf '%s\n' 'GOOGLE_OAUTH_CLIENT_SECRET is required.'; exit 1; }

dry-run: check-python
	@test -r "$(ENV_FILE)" || { printf '%s\n' 'Missing setenv.sh. Copy setenv.example.sh first.'; exit 1; }
	@set -a; . "./$(ENV_FILE)"; set +a; \
	  $(PYTHON) "$(BOOTSTRAP_SCRIPT)" \
	    --source-root "$(CURDIR)" \
	    --reference-url "$$REFERENCE_DRIVE_DIR" \
	    --user-url "$$USER_DRIVE_DIR" \
	    --dry-run

deploy: check-python check-config
	@set -a; . "./$(ENV_FILE)"; set +a; \
	  $(PYTHON) "$(BOOTSTRAP_SCRIPT)" \
	    --source-root "$(CURDIR)" \
	    --reference-url "$$REFERENCE_DRIVE_DIR" \
	    --user-url "$$USER_DRIVE_DIR"
