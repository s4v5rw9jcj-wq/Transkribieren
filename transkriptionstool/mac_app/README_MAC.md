# Transkriptionstool für macOS

Ein einfaches Tool zum Transkribieren von MP4-Dateien in Word-Dokumente, optimiert für macOS.

## 🍎 macOS-spezifische Funktionen

- ✅ **Native macOS Integration** - Optimiert für macOS mit Retina-Display-Unterstützung
- ✅ **Finder-Integration** - Automatisches Öffnen des Ergebnisordners im Finder
- ✅ **Einfache Installation** - Setup-Skript für einfache Einrichtung
- ✅ **.app Bundle** - Kann als eigenständige Anwendung installiert werden

## 📋 Voraussetzungen

- **macOS 10.15 (Catalina) oder höher**
- **Python 3.7 oder höher**
- **Internetverbindung** (für Google Speech Recognition, optional)

## 🚀 Installation

### Option 1: Einfache Installation (empfohlen)

1. **Terminal öffnen**
2. **In das Projektverzeichnis wechseln:**
   ```bash
   cd /Pfad/zum/Transkribieren/transkriptionstool/mac_app
   ```

3. **Setup-Skript ausführen:**
   ```bash
   chmod +x setup_mac.sh
   ./setup_mac.sh
   ```

4. **Anwendung starten:**
   - Öffnen Sie den Finder
   - Navigieren Sie zu `~/Applications/`
   - Doppelklicken Sie auf **Transkriptionstool.app**

### Option 2: Manuelle Installation

1. **Abhängigkeiten installieren:**
   ```bash
   pip3 install moviepy SpeechRecognition pydub python-docx Pillow
   ```

2. **Tkinter installieren (falls nicht vorhanden):**
   ```bash
   brew install python-tk
   ```

3. **Tool direkt starten:**
   ```bash
   python3 main_mac.py
   ```

## 📖 Verwendung

### Mit .app Bundle

1. **Anwendung öffnen** - Doppelklick auf Transkriptionstool.app
2. **Datei auswählen** - Klicken Sie auf "MP4-Datei auswählen..."
3. **Transkription starten** - Klicken Sie auf "Transkription starten"
4. **Warten** - Das Tool verarbeitet die Datei
5. **Ergebnis** - Die Word-Datei wird automatisch im Finder geöffnet

### Über Terminal

```bash
# Einfache Version
python3 main_mac.py

# Oder die Konsolenversion
python3 ../transcribe.py
```

## 🔧 Fehlerbehebung

### Häufige Probleme auf macOS

#### 1. "Python 3 nicht gefunden"
```bash
# Python 3 installieren
brew install python
```

#### 2. "Tkinter nicht gefunden"
```bash
# Tkinter installieren
brew install python-tk
```

#### 3. "Command not found: pip3"
```bash
# pip installieren
python3 -m ensurepip --upgrade
```

#### 4. "MoviePy Fehler"
```bash
# FFmpeg installieren (wird von MoviePy benötigt)
brew install ffmpeg
```

#### 5. "App kann nicht geöffnet werden, weil sie von einem nicht identifizierten Entwickler stammt"
```bash
# App explizit erlauben
xattr -d com.apple.quarantine ~/Applications/Transkriptionstool.app
```

## 📁 Dateistruktur

```
mac_app/
├── Transkriptionstool.app/          # .app Bundle
│   ├── Contents/
│   │   ├── Info.plist              # App-Informationen
│   │   ├── MacOS/
│   │   │   └── run.sh              # Startskript
│   │   └── Resources/              # Ressourcen (Icons, Skripte)
│   │       ├── icon.icns           # App-Icon
│   │       ├── main_mac.py         # Hauptskript
│   │       └── requirements.txt    # Abhängigkeiten
├── setup_mac.sh                    # Setup-Skript
└── README_MAC.md                   # Diese Datei
```

## 🎨 App-Icon

Das Tool verwendet ein einfaches Mikrofon-Icon. Sie können ein eigenes Icon erstellen:

1. **Icon-Datei vorbereiten** - Erstellen Sie eine `.icns`-Datei
2. **Icon ersetzen** - Kopieren Sie Ihre `.icns`-Datei nach:
   ```
   Transkriptionstool.app/Contents/Resources/icon.icns
   ```

## 🔄 Deinstallation

### .app Bundle entfernen
```bash
rm -rf ~/Applications/Transkriptionstool.app
```

### Python-Pakete deinstallieren
```bash
pip3 uninstall moviepy SpeechRecognition pydub python-docx Pillow
```

## 💡 Tipps für macOS

### Tastaturkürzel
- **⌘ + O** - Datei öffnen (wenn implementiert)
- **⌘ + Q** - Anwendung beenden
- **⌘ + ,** - Einstellungen (falls verfügbar)

### Dark Mode
Das Tool passt sich automatisch dem macOS Dark Mode an.

### Retina-Displays
Das Tool unterstützt hochauflösende Retina-Displays.

## 🌐 Offline-Modus

Das Tool funktioniert auch ohne Internetverbindung:
- **Mit Internet:** Google Speech Recognition (genauer)
- **Ohne Internet:** Sphinx Spracherkennung (offline, weniger genau)

## 📝 Sprache ändern

Um die Sprache zu ändern, bearbeiten Sie in `main_mac.py`:

```python
# Zeile 245 ändern von:
text = self.recognizer.recognize_google(audio_data, language="de-DE")

# Zu z.B. Englisch:
text = self.recognizer.recognize_google(audio_data, language="en-US")

# Oder Französisch:
text = self.recognizer.recognize_google(audio_data, language="fr-FR")
```

## 🔒 Berechtigungen

### Mikrofonzugriff (falls benötigt)
1. Systemeinstellungen → Sicherheit & Datenschutz
2. Datenschutz → Mikrofon
3. Transkriptionstool hinzufügen

### Dateizugriff
Das Tool benötigt Zugriff auf:
- Den Ordner, in dem sich Ihre MP4-Dateien befinden
- Den Ordner, in dem die Word-Dateien gespeichert werden

## 📊 Leistungstipps

- **Kleinere Dateien** - Große Dateien (>100MB) können länger dauern
- **Gute Audioqualität** - Klare Audioaufnahmen verbessern die Erkennungsgenauigkeit
- **Stabile Internetverbindung** - Für beste Ergebnisse mit Google Speech Recognition

## 🤝 Unterstützung

Bei Problemen oder Fragen:
1. Überprüfen Sie die Fehlerbehebung in dieser README
2. Stellen Sie sicher, dass alle Abhängigkeiten installiert sind
3. Testen Sie mit einer kleinen MP4-Datei

## 📄 Lizenz

Dieses Tool ist Open Source und kann frei verwendet werden.

---

**Viel Spaß mit dem Transkriptionstool auf Ihrem Mac! 🍏**
