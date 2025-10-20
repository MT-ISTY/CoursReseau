#!/bin/bash
# ---------------------------------------------------------
# Script de synchronisation Git simple pour cours/projets
# Auteur : MT-ISTY
# ---------------------------------------------------------

# Vérifie que l'on est bien dans un dépôt Git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Ce dossier n'est pas un dépôt Git."
    exit 1
fi

echo "📁 Répertoire : $(git rev-parse --show-toplevel)"
echo "🌿 Branche courante : $(git branch --show-current)"
echo "🔗 Remote : $(git remote -v | head -1)"
echo

# Vérifie l'état du dépôt
git status --short

# Ajoute toutes les modifications
echo
echo "➕ Ajout des fichiers modifiés..."
git add -A

# Vérifie s'il y a des modifications à committer
if git diff --cached --quiet; then
    echo "✅ Rien de nouveau à committer."
else
    # Commit avec message automatique incluant la date
    msg="Mise à jour auto : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "💬 Commit : $msg"
    git commit -m "$msg"
fi

# Pousse sur le dépôt distant
echo
echo "⬆️  Envoi vers GitHub..."
git push -u origin $(git branch --show-current)

echo
echo "🎉 Synchronisation terminée !"
