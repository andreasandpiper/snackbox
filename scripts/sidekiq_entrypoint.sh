#!/bin/bash
set -e

bundle exec rake assets:precompile

# Wait for database to be ready
until nc -z -v -w30 $POSTGRES_HOST $POSTGRES_PORT; do
 echo 'Waiting for Postgres...'
 sleep 1
done
echo "Postgres is up and running!"

rm -f tmp/pids/sidekiq.pid

bundle exec sidekiq -q default -q mailers

exec "$@"
