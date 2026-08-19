#!/bin/bash

# Transkriptionstool für macOS
# Diese Datei wird vom .app Bundle ausgeführt

# Verzeichnis des .app Bundles
APP_DIR="$(dirname "$(dirname "$(dirname "$0")")")"
RESOURCES_DIR="$APP_DIR/Contents/Resources"

# In das Ressourcenverzeichnis wechseln
cd "$RESOURCES_DIR"

# Python ausführen
python3 main_simple.py
