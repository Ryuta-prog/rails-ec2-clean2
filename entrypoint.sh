#!/bin/bash
set -e

# ターミナル接続の遅延対策
sleep 0.1

# PostgreSQLが起動するまで待機
until PGPASSWORD=$POSTGRES_PASSWORD psql -h db -U postgres -d postgres -c '\q'; do
  echo "PostgreSQLが起動するまで待機中..."
  sleep 1
done

# マイグレーション実行
bundle exec rails db:migrate

# メインコマンド実行
exec "$@"
