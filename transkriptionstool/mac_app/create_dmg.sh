#!/bin/bash

# Skript zum Erstellen eines DMG-Images für macOS
# Benötigt: create-dmg (https://github.com/andreyvit/create-dmg)

echo "🍎 DMG-Image für Transkriptionstool erstellen"
echo "=============================================="
echo ""

# Überprüfen ob create-dmg installiert ist
if ! command -v create-dmg &> /dev/null; then
    echo "❌ create-dmg nicht gefunden!"
    echo ""
    echo "Installieren Sie create-dmg mit:"
    echo "  brew install create-dmg"
    exit 1
fi

# Verzeichnisse
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_NAME="Transkriptionstool"
APP_DIR="$SCRIPT_DIR/$APP_NAME.app"
DMG_NAME="$APP_NAME.dmg"
DMG_DIR="$SCRIPT_DIR/dmg"
FINAL_DMG="$SCRIPT_DIR/$DMG_NAME"

# .app Bundle erstellen
echo "🛠️  Erstelle .app Bundle..."
if [ ! -d "$APP_DIR" ]; then
    echo "❌ .app Bundle nicht gefunden!"
    echo "Führen Sie zuerst setup_mac.sh aus."
    exit 1
fi

# Temporäres Verzeichnis für DMG erstellen
echo "📁 Erstelle temporäres DMG-Verzeichnis..."
rm -rf "$DMG_DIR"
mkdir -p "$DMG_DIR"

# .app Bundle kopieren
cp -R "$APP_DIR" "$DMG_DIR/"

# Hintergrundbild erstellen (optional)
echo "🎨 Erstelle Hintergrundbild..."
python3 - << 'EOF'
from PIL import Image, ImageDraw, ImageFont
import os

# Hintergrundbild erstellen
img_size = (600, 400)
img = Image.new('RGB', img_size, (240, 240, 240))
draw = ImageDraw.Draw(img)

# App-Icon Position markieren
draw.ellipse([(150, 100), (450, 300)], outline=(200, 200, 200), width=2)

# Text hinzufügen
try:
    font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 24)
    draw.text((300, 350), "Ziehen Sie das App-Symbol", fill=(100, 100, 100), anchor="mm", font=font)
    draw.text((300, 380), "in den Applications-Ordner", fill=(100, 100, 100), anchor="mm", font=font)
except:
    pass

img.save("$DMG_DIR/background.png")
print("✅ Hintergrundbild erstellt")
EOF

# DMG erstellen
echo "💾 Erstelle DMG-Image..."
create-dmg \
    --volname "$APP_NAME" \
    --volicon "$APP_DIR/Contents/Resources/icon.icns" \
    --background "$DMG_DIR/background.png" \
    --window-pos 200 120 \
    --window-size 600 400 \
    --icon-size 128 \
    --icon "$APP_NAME.app" 150 150 \
    --app-drop-link 450 150 \
    "$FINAL_DMG" \
    "$DMG_DIR"

# Temporäres Verzeichnis bereinigen
rm -rf "$DMG_DIR"

# Erfolgmeldung
echo ""
echo "✅ DMG-Image erstellt: $FINAL_DMG"
echo ""
echo "📋 Zusammenfassung:"
echo "================="
echo ""
echo "📁 DMG-Datei: $FINAL_DMG"
echo "📊 Größe: $(du -h "$FINAL_DMG" | cut -f1)"
echo ""
echo "🚀 Zum Installieren:"
echo "   1. Doppelklicken Sie auf die DMG-Datei"
echo "   2. Ziehen Sie Transkriptionstool.app in den Applications-Ordner"
echo "   3. Starten Sie die Anwendung aus dem Applications-Ordner"
echo ""
echo "✨ Fertig!"
