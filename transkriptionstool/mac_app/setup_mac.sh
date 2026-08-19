#!/bin/bash

# Setup-Skript für macOS
# Installiert alle Abhängigkeiten und erstellt die .app Anwendung

echo "🍎 Transkriptionstool für macOS - Setup"
echo "========================================"
echo ""

# Überprüfen ob Python 3 installiert ist
echo "🔍 Überprüfe Python 3 Installation..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 ist nicht installiert!"
    echo ""
    echo "Bitte installieren Sie Python 3 von https://www.python.org/downloads/macos/"
    echo "oder mit Homebrew: brew install python"
    exit 1
fi
echo "✅ Python 3 gefunden: $(python3 --version)"
echo ""

# Überprüfen ob pip installiert ist
echo "🔍 Überprüfe pip Installation..."
if ! python3 -m pip --version &> /dev/null; then
    echo "❌ pip ist nicht installiert!"
    echo ""
    echo "Bitte installieren Sie pip mit: python3 -m ensurepip --upgrade"
    exit 1
fi
echo "✅ pip gefunden"
echo ""

# Abhängigkeiten installieren
echo "📦 Installiere Abhängigkeiten..."
python3 -m pip install --user moviepy SpeechRecognition pydub python-docx Pillow
if [ $? -ne 0 ]; then
    echo "❌ Fehler beim Installieren der Abhängigkeiten!"
    echo ""
    echo "Versuchen Sie: pip install --upgrade pip"
    echo "Dann führen Sie das Setup erneut aus."
    exit 1
fi
echo "✅ Abhängigkeiten installiert"
echo ""

# Tkinter überprüfen
echo "🔍 Überprüfe Tkinter..."
if ! python3 -c "import tkinter" 2> /dev/null; then
    echo "⚠️  Tkinter ist nicht installiert"
    echo ""
    echo "Installieren Sie Tkinter mit:"
    echo "  brew install python-tk"
    echo ""
    echo "Oder installieren Sie die ActiveTcl Community Edition von:"
    echo "  https://www.activestate.com/products/tcl/"
    read -p "Möchten Sie fortfahren ohne Tkinter? (j/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Jj]$ ]]; then
        exit 1
    fi
else
    echo "✅ Tkinter gefunden"
fi
echo ""

# .app Bundle erstellen
echo "🛠️  Erstelle .app Bundle..."

# Verzeichnis erstellen
APP_NAME="Transkriptionstool.app"
APP_DIR="$HOME/Applications/$APP_NAME"
RESOURCES_DIR="$APP_DIR/Contents/Resources"

# Vorhandene Installation entfernen
if [ -d "$APP_DIR" ]; then
    echo "🗑️  Entferne alte Installation..."
    rm -rf "$APP_DIR"
fi

# .app Struktur erstellen
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$RESOURCES_DIR"

# Info.plist kopieren
cp "$(dirname "$0")/Transkriptionstool.app/Contents/Info.plist" "$APP_DIR/Contents/Info.plist"

# run.sh kopieren und ausführbar machen
cp "$(dirname "$0")/Transkriptionstool.app/Contents/MacOS/run.sh" "$APP_DIR/Contents/MacOS/"
chmod +x "$APP_DIR/Contents/MacOS/run.sh"

# Python-Skripte kopieren
cp "$(dirname "$0")/../main_simple.py" "$RESOURCES_DIR/"
cp "$(dirname "$0")/../transcribe.py" "$RESOURCES_DIR/"
cp "$(dirname "$0")/../requirements.txt" "$RESOURCES_DIR/"

# Icon erstellen (einfaches Platzhalter-Icon)
echo "🎨 Erstelle App-Icon..."
# Einfaches Icon mit Python erstellen
python3 - << 'EOF'
import os
from PIL import Image, ImageDraw

# Icon erstellen
icon_path = "$RESOURCES_DIR/icon.icns"
size = 512

# Leeres Bild erstellen
img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Einfaches Mikrofon-Icon zeichnen
draw.ellipse([(size//4, size//4), (3*size//4, 3*size//4)], fill=(50, 150, 250, 255))
draw.ellipse([(size//3, size//3), (2*size//3, 2*size//3)], fill=(255, 255, 255, 255))

# Als PNG speichern (für .icns brauchen wir mehrere Größen)
img.save(os.path.join("$RESOURCES_DIR", "icon_512.png"))
print("✅ Icon erstellt")
EOF

# .icns Datei erstellen (einfache Version)
# Für eine echte .app benötigen wir eine .icns Datei
# Wir erstellen eine einfache mit sips
if command -v sips &> /dev/null; then
    # Icon aus PNG erstellen
    mkdir -p "$RESOURCES_DIR/icon.iconset"
    
    # Mehrere Größen erstellen
    for size in 16 32 64 128 256 512; do
        python3 - << EOF
from PIL import Image
import os

img = Image.new('RGBA', (512, 512), (0, 0, 0, 0))
from PIL import ImageDraw
draw = ImageDraw.Draw(img)
draw.ellipse([(128, 128), (384, 384)], fill=(50, 150, 250, 255))
draw.ellipse([(170, 170), (342, 342)], fill=(255, 255, 255, 255))

# Auf gewünschte Größe skalieren
resized = img.resize(($size, $size), Image.LANCZOS)
resized.save("$RESOURCES_DIR/icon.iconset/icon_${size}x${size}.png")
EOF
    done
    
    # .icns Datei erstellen
    iconutil -c icns "$RESOURCES_DIR/icon.iconset" -o "$RESOURCES_DIR/icon.icns"
    rm -rf "$RESOURCES_DIR/icon.iconset"
    echo "✅ .icns Datei erstellt"
else
    echo "⚠️  sips nicht gefunden, verwende PNG als Icon"
    cp "$RESOURCES_DIR/icon_512.png" "$RESOURCES_DIR/icon.icns"
fi

echo ""
echo "✅ .app Bundle erstellt: $APP_DIR"
echo ""

echo "📋 Zusammenfassung:"
echo "================="
echo ""
echo "📁 Anwendung: $APP_DIR"
echo ""
echo "🚀 Zum Starten:"
echo "   1. Öffnen Sie den Finder"
echo "   2. Navigieren Sie zu: $HOME/Applications/"
echo "   3. Doppelklicken Sie auf 'Transkriptionstool.app'"
echo ""
echo "💡 Alternativ können Sie das Tool auch direkt starten mit:"
echo "   python3 $(dirname "$0")/../main_simple.py"
echo ""
echo "✨ Setup abgeschlossen!"
