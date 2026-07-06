#!/usr/bin/env bash
set -e

echo "🚀 Starting..."
docker compose up -d --build

echo "🗄 Migration..."
docker compose exec -T app bin/rails db:migrate

echo "🗄 Seeding..."
docker compose exec -T app bin/rails db:seed

echo "✅ Done! Go to http://localhost:3000"