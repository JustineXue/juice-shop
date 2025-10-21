#!/bin/bash
set -e

# Directory to store artifacts
ARTIFACT_DIR="./artifacts"

echo "📥 Fetching latest test-results artifact from GitHub Actions..."

TEST_OUTPUT_FILE="$ARTIFACT_DIR/test-output.txt"
# Delete existing file if it exists
if [[ -f "$TEST_OUTPUT_FILE" ]]; then
    echo "⚠️ Existing test-output.txt found. Deleting it..."
    rm "$TEST_OUTPUT_FILE"
fi

# Download the latest artifact named "test-output"
gh run download --name "test-results" --dir "$ARTIFACT_DIR"

# Verify the file exists
if [[ -f "$TEST_OUTPUT_FILE" ]]; then
    echo "✅ Test results downloaded to $ARTIFACT_DIR/test-output.txt"
    echo
    echo "📄 Test output preview:"
    echo "--------------------------------"
    tail -n 20 "$ARTIFACT_DIR/test-output.txt"
    echo "--------------------------------"
else
    echo "❌ Could not find test-output.txt in artifact."
    exit 1
fi
