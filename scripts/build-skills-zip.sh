#!/usr/bin/env bash
# Fabrique une archive par skill pour claude.ai et Claude Desktop (Personnaliser → Skills → Téléverser une skill).
# Chaque archive contient le dossier de la skill à sa racine (<nom>/SKILL.md), comme claude.ai l'exige.
# Usage, depuis la racine du dépôt : bash scripts/build-skills-zip.sh   → dist/<nom>.zip
set -euo pipefail
cd "$(dirname "$0")/.."
SRC=plugins/heberghub/skills
mkdir -p dist
rm -f dist/*.zip
for dir in "$SRC"/*/; do
  name=$(basename "$dir")
  head -5 "$dir/SKILL.md" | grep -q "^name: $name\$" || { echo "REFUS : $dir/SKILL.md n'a pas « name: $name »"; exit 1; }
  # claude.ai n'accepte que name, description, license, compatibility, metadata, allowed-tools dans l'en-tête
  extra=$(sed -n '2,/^---$/p' "$dir/SKILL.md" | grep -E '^[a-z_-]+:' | cut -d: -f1 | grep -v -x -E 'name|description|license|compatibility|metadata|allowed-tools' || true)
  [ -z "$extra" ] || { echo "REFUS : champs non acceptés par claude.ai dans $name : $extra"; exit 1; }
  if command -v zip >/dev/null; then
    (cd "$SRC" && zip -qr "../../../dist/$name.zip" "$name")
  else
    # Poste sans zip (Git Bash sous Windows) : même archive par Python
    (cd "$SRC" && python -c 'import sys,os,zipfile
n,out=sys.argv[1],sys.argv[2]
with zipfile.ZipFile(out,"w",zipfile.ZIP_DEFLATED) as z:
    for r,_,fs in os.walk(n):
        for f in fs: z.write(os.path.join(r,f), os.path.join(r,f).replace(os.sep,"/"))' "$name" "../../../dist/$name.zip")
  fi
  echo "dist/$name.zip"
done
