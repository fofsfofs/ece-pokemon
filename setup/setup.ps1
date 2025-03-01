$PYTHON_VERSION = "3.13.0"

# Check if pyenv is installed
if (-Not (Get-Command pyenv -ErrorAction SilentlyContinue)) {
    Write-Host "Installing pyenv..."
    winget install pyenv-win
}

# Restart shell to recognize pyenv (only needed if first install)
$env:Path += ";$env:USERPROFILE\.pyenv\pyenv-win\bin;$env:USERPROFILE\.pyenv\pyenv-win\shims"

# Install Python 3.13.0 if not installed
if (-Not (pyenv versions | Select-String $PYTHON_VERSION)) {
    Write-Host "Installing Python $PYTHON_VERSION..."
    pyenv install $PYTHON_VERSION
}

# Set Python 3.13.0 as global default
pyenv global $PYTHON_VERSION
pyenv rehash
pyenv exec python -m install -r ".\requirements.txt"

# Commit hook
pyenv exec pre-commit install
# Run check
pyenv exec python check.py