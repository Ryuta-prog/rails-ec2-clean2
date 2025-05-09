#!/bin/bash
set -e

# ターミナル接続の遅延対策
sleep 0.1

# PostgreSQL が起動するまで待機
until PGPASSWORD=$POSTGRES_PASSWORD psql -h db -U postgres -d postgres -c '\q'; do
  echo "PostgreSQL が起動するまで待機中…"
  sleep 1
done

# マイグレーション実行
bundle exec rails db:migrate

# （開発環境なら）esbuild & sass ビルド
if [ "$RAILS_ENV" = "development" ]; then
  echo " アセットをビルドしています…"
  ./bin/build
fi

# 最後にメインコマンドを実行
exec "$@"
