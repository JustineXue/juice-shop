#!/bin/bash
set -e

# Directories
ARTIFACT_DIR="./artifacts"

echo "📥 Fetching latest semgrep-results artifact from GitHub Actions..."

SCAN_OUTPUT_FILE="$ARTIFACT_DIR/semgrep_output.txt"
# Delete existing file if it exists
if [[ -f "$SCAN_OUTPUT_FILE" ]]; then
    echo "⚠️ Existing semgrep_output.txt found. Deleting it..."
    rm "$SCAN_OUTPUT_FILE"
fi

# Download the latest artifact named "semgrep-security-results"
gh run download --name "semgrep-results" --dir "$ARTIFACT_DIR"

# Verify the file exists
if [[ -f "$SCAN_OUTPUT_FILE" ]]; then
    echo "✅ Security scan results downloaded to $SCAN_OUTPUT_FILE"
    echo
    echo "📄 Semgrep output preview:"
    echo "--------------------------------"
    tail -n 20 "$SCAN_OUTPUT_FILE"
    echo "--------------------------------"
else
    echo "❌ Could not find semgrep-report.txt in artifact."
    exit 1
fi