# SnackBox

# Setup

### Requirements

- Docker

### Steps

1. build images `docker-compose build`
2. run containers `docker-compose up -d`
3. create db and run migration if not already `docker-compose run web rails db:create db:migrate`
4. head to localhost:3000