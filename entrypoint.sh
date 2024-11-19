#!/bin/bash
set -e

# サーバーPIDファイルの削除（Railsが再起動できるようにする）
rm -f /myapp/tmp/pids/server.pid

# データベースの作成とマイグレーション
bundle exec rails db:create || true
bundle exec rails db:migrate || true

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"