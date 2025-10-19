.PHONY: help install test lint format clean train run notebook

# Variables
PYTHON := 3.11
VENV := .venv
UV := uv

help:  ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install:  ## Install the virtual environment and dependencies
	@echo "Installing the Python virtual environment..."
	$(UV) venv --python $(PYTHON)
	@echo "Installing Python dependencies..."
	. $(VENV)/bin/activate && $(UV) pip install -r requirements.txt
	@echo "Installation complete."
	@echo "To activate: source $(VENV)/bin/activate"

install-dev: install  ## Install the pre-commit hooks
	@echo "Installing pre-commit hooks..."
	. $(VENV)/bin/activate && pre-commit install
	@echo "Pre-commit hooks configured."

test:  ## Run all tests
	@echo "Running all tests..."
	$(PYTHON) -m pytest tests/ -v --cov

test-unit:  ## Run only the unit tests
	@echo "Running unit tests..."
	$(PYTHON) -m pytest tests/ -m "unit" -v

test-integration:  ## Run only the integration tests
	@echo "Running integration tests..."
	$(PYTHON) -m pytest tests/ -m "integration" -v

lint:  ## Check the code quality (ruff + mypy)
	@echo "Checking code quality..."
	ruff check .
	@echo "Type checking..."
	mypy app/ etl/ models/ --ignore-missing-imports || true

format:  ## Format the code automatically
	@echo "Formatting code..."
	ruff format .
	ruff check --fix .
	@echo "Code formatting done."

clean:  ## Clean the temporary files
	@echo "Cleaning up temporary files..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf .pytest_cache .mypy_cache .ruff_cache htmlcov/ .coverage
	@echo "Cleanup complete."

train:  ## Train the model
	@echo "Training the model..."
	$(PYTHON) models/train.py

run:  ## Run the FastAPI API locally
	@echo "Starting the FastAPI API locally..."
	uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

notebook:  ## Run Jupyter Notebook
	@echo "Starting Jupyter Notebook..."
	jupyter notebook notebooks/

setup-git:  ## Initialize Git with the base configuration
	@echo "Configuring Git..."
	git config user.name "Ammar MSE" || true
	git config user.email "ammar@example.com" || true
	@echo "Git configured."

init:  ## Complete project setup (first time)
	@echo "Full project initialization..."
	@make install
	@make setup-git
	@echo ""
	@echo "Project initialized."
	@echo "Next steps:"
	@echo "   1. Activate the environment: source .venv/bin/activate"
	@echo "   2. Set up .env with your API keys"
	@echo "   3. Initialize Git: git init"
	@echo "   4. First commit: git add . && git commit -m 'feat: initial setup'"
