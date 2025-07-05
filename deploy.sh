#!/bin/bash

# Cek input commit message
if [ -z "$1" ]; then
  echo "❌ ERROR: Harap masukkan pesan commit."
  echo "🔧 Contoh: ./deploy.sh \"update artikel dan fix typo\""
  exit 1
fi

# Git add, commit, and push
echo "📤 Committing and pushing to GitHub..."
git add .
git commit -m "$1"
git push origin main

echo "✅ Selesai: Perubahan dikirim ke GitHub dan Netlify akan membuild otomatis."
