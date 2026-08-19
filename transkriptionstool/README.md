# MP4 Transkriptionstool

Ein einfaches Tool zum Transkribieren von MP4-Dateien in Word-Dokumente.

## Funktionen

- 📁 **Datei-Upload**: Einfaches Hochladen von MP4-Dateien
- 🎵 **Audio-Extraktion**: Automatische Extraktion des Audios aus MP4-Dateien
- 🗣️ **Spracherkennung**: Konvertierung von Audio in Text (Deutsch)
- 📄 **Word-Export**: Speichert das Transkript als Word-Datei (.docx)
- 📊 **Fortschrittsanzeige**: Zeigt den Fortschritt der Verarbeitung an
- 💻 **Automatische GUI-Erkennung**: Nutzt Tkinter falls verfügbar, sonst Konsolenversion

## Voraussetzungen

- Python 3.7 oder höher
- Internetverbindung (für Google Speech Recognition - optional)

## Installation

### Option 1: Einfache Installation (empfohlen)

```bash
# In das Verzeichnis wechseln
cd transkriptionstool

# Abhängigkeiten installieren
pip install -r requirements.txt

# Tool starten
python -m transkriptionstool
```

### Option 2: Als Paket installieren

```bash
pip install -e .
transkriptionstool
```

### Option 3: Manuelle Installation

```bash
pip install moviepy SpeechRecognition pydub python-docx Pillow
```

### Zusätzliche Abhängigkeiten für Audio-Verarbeitung (optional)

Für bessere Audio-Unterstützung können Sie PyAudio installieren:

#### Auf Windows:
```bash
pip install pyaudio
```

#### Auf macOS:
```bash
brew install portaudio
pip install pyaudio
```

#### Auf Linux (Debian/Ubuntu):
```bash
sudo apt-get install portaudio19-dev python3-pyaudio
pip install pyaudio
```

#### Tkinter für GUI (falls nicht installiert)

#### Auf Ubuntu/Debian:
```bash
sudo apt-get install python3-tk
```

#### Auf Fedora:
```bash
sudo dnf install python3-tkinter
```

#### Auf macOS (mit Homebrew):
```bash
brew install python-tk
```

## Verwendung

### GUI-Version (falls Tkinter verfügbar)

```bash
python main_simple.py
# oder
python -m transkriptionstool
```

### Konsolenversion (falls keine GUI verfügbar)

```bash
python transcribe.py
```

### Mit Drag & Drop (falls tkinterdnd2 installiert)

```bash
pip install tkinterdnd2
python main.py
```

## Anleitung

1. **Datei auswählen**: Klicken Sie auf "MP4-Datei auswählen" und wählen Sie Ihre MP4-Datei aus
2. **Transkription starten**: Klicken Sie auf "Transkribieren starten"
3. **Warten**: Das Tool extrahiert das Audio und transkribiert es
4. **Ergebnis**: Die Word-Datei wird im gleichen Ordner wie die MP4-Datei gespeichert

## Technische Details

### Unterstützte Formate
- MP4-Dateien mit Audio-Spur

### Spracherkennung
- Primär: Google Speech Recognition (benötigt Internet)
- Fallback: Sphinx (offline, weniger genau)

### Chunk-Verarbeitung
- Das Audio wird in 30-Sekunden-Chunks aufgeteilt
- Jeder Chunk wird einzeln verarbeitet
- Fortschritt wird in Echtzeit angezeigt

## Fehlerbehebung

### Häufige Probleme

1. **"No module named 'tkinter'"**
   - Installieren Sie Tkinter für Ihr Betriebssystem (siehe oben)

2. **"Could not open port" (Audio-Fehler)**
   - Installieren Sie PyAudio wie oben beschrieben

3. **"API unavailable" (Google Speech Recognition)**
   - Überprüfen Sie Ihre Internetverbindung
   - Versuchen Sie es später erneut
   - Das Tool fällt auf Sphinx (offline) zurück

4. **Lange Verarbeitungszeit**
   - Große Dateien werden in Chunks verarbeitet
   - Die Verarbeitung kann je nach Dateigröße und Internetverbindung einige Minuten dauern

## Dateistruktur

```
transkriptionstool/
├── __main__.py        # Hauptdatei - wählt automatisch die beste GUI
├── main.py            # Version mit Drag & Drop (benötigt tkinterdnd2)
├── main_simple.py     # Einfache GUI-Version (nur Tkinter)
├── transcribe.py      # Konsolenversion
├── requirements.txt   # Abhängigkeiten
├── setup.py           # Setup-Skript für Paketinstallation
├── run.bat            # Batch-Datei für Windows
├── run.sh             # Shell-Skript für Linux/macOS
└── README.md          # Diese Datei
```

## Lizenz

Dieses Tool ist Open Source und kann frei verwendet werden.

## Hinweise

- Die Genauigkeit der Spracherkennung hängt von der Audioqualität ab
- Für beste Ergebnisse verwenden Sie klare Audioaufnahmen
- Das Tool unterstützt derzeit nur Deutsch (kann in den Code angepasst werden)
- Die Word-Datei wird mit demselben Namen wie die MP4-Datei gespeichert, mit dem Suffix "_transkription.docx"
- Ohne Internetverbindung wird Sphinx (offline Spracherkennung) verwendet

## Sprache ändern

Um die Sprache zu ändern, bearbeiten Sie in den Dateien `main.py`, `main_simple.py` oder `transcribe.py`:

```python
# Für Englisch
text = recognizer.recognize_google(audio_data, language="en-US")

# Für Französisch
text = recognizer.recognize_google(audio_data, language="fr-FR")

# Für Spanisch
text = recognizer.recognize_google(audio_data, language="es-ES")
```

## Beitrag leisten

1. Forken Sie das Repository
2. Erstellen Sie einen Feature-Branch
3. Committen Sie Ihre Änderungen
4. Pushen Sie zum Branch
5. Erstellen Sie einen Pull Request
