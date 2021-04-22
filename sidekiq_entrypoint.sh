#!/bin/bash

bundle exec sidekiq -q default -q mailers

exec "$@"
