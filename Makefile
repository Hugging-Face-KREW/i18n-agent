# Makefile for uv-based Python project setup

VENV_DIR=.venv
REQ=requirements.txt

.PHONY: install clean venv ensure-uv

install: venv
	@read -p "Do you want to install the packages? (y/n): " yn; \
	if [ "$$yn" = "y" ]; then \
		. $(VENV_DIR)/bin/activate && uv pip install -r $(REQ); \
	else \
		echo "Installation cancelled."; \
	fi

venv: ensure-uv
	uv venv $(VENV_DIR) || true

ensure-uv:
	@command -v uv >/dev/null 2>&1 || (echo "uv not found, installing..." && curl -Ls https://astral.sh/uv/install.sh | sh)

clean:
	rm -rf $(VENV_DIR)