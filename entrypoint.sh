#!/bin/bash
set -e

# PostgreSQLが起動するまで待機
until PGPASSWORD=$POSTGRES_PASSWORD psql -h db -U postgres -d postgres -c '\q'; do
  echo "PostgreSQLが起動するまで待機中..."
  sleep 1
done

# マイグレーション実行
bundle exec rails db:migrate
