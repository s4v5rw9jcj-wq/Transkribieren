#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Hauptdatei für das Transkriptionstool
Wählt automatisch die beste verfügbare GUI aus.
"""

import sys
import importlib


def main():
    """Hauptfunktion - wählt die beste verfügbare GUI"""
    
    # Versuche Tkinter zu importieren
    try:
        import tkinter as tk
        from tkinter import ttk
        print("Tkinter ist verfügbar - starte GUI-Version")
        
        # Versuche die einfache GUI zu starten
        try:
            from main_simple import TranskriptionsApp
            root = tk.Tk()
            app = TranskriptionsApp(root)
            root.mainloop()
        except ImportError as e:
            print(f"Fehler beim Laden der GUI: {e}")
            # Versuche die Konsolenversion
            start_console_version()
            
    except ImportError:
        print("Tkinter ist nicht verfügbar - starte Konsolenversion")
        start_console_version()


def start_console_version():
    """Startet die Konsolenversion"""
    try:
        from transcribe import main as console_main
        console_main()
    except ImportError as e:
        print(f"Fehler: {e}")
        print("Bitte installieren Sie die erforderlichen Abhängigkeiten:")
        print("pip install -r requirements.txt")


if __name__ == "__main__":
    main()
