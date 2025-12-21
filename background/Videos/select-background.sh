#!/bin/zsh

# Pfad zur Textdatei mit der Liste der Videodateien
LISTE_DATEI="backgrounds.txt"  # ggf. absoluten Pfad angeben

# Prüfen, ob die Datei existiert
if [[ ! -f "$LISTE_DATEI" ]]; then
  echo "Fehler: Datei $LISTE_DATEI nicht gefunden."
  exit 1
fi

# Mit fzf eine Datei auswählen
auswahl=$(cat "$LISTE_DATEI" | fzf --prompt="Wähle eine Datei: ")

# Prüfen, ob eine Auswahl getroffen wurde
if [[ -z "$auswahl" ]]; then
  echo "Keine Datei ausgewählt."
  exit 0
fi

# Zielpfad
ziel="$HOME/Videos/background.mp4"

# Existierenden Link oder Datei löschen
if [[ -e "$ziel" || -L "$ziel" ]]; then
  rm "$ziel"
fi

# Symbolischen Link erstellen
ln -s "$auswahl" "$ziel"

echo "Verlinkt: $auswahl -> $ziel"

