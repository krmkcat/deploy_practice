#!/bin/bash
set -e

# Rails に対応したファイル server.pid が存在しているかもしれないので削除する。
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

# コンテナーのプロセスを実行する。（Dockerfile 内の CMD に設定されているもの。）
exec "$@"