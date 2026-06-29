#!/bin/zsh
set -euo pipefail

SCRIPT_DIR=${0:A:h}
python3 "$SCRIPT_DIR/generate_view_docs.py"
