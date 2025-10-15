#!/bin/bash
set -e

echo "Running database migration..."
bin/rails db:migrate

echo "Seeding production database..."
bin/rails db:seed_production

echo "Production database setup completed!"
