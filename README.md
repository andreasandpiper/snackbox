# SnackBox

# Setup

### Requirements

- Docker

### Steps

1. Build images `docker-compose build`
2. Run containers `docker-compose up -d`
3. Head to `localhost:8080`

## Debugging

- `docker attach snackbox_web_1` and add a `byebug` in the code to debug
- Use mailcatcher to check email content, if not already running `docker-compose up -d mailcatcher` and open `localhost:1080`

## Environment variables

- Make changes to variables with `EDITOR=vim rails credentials:edit --environment {ENVIRONMENT}`

## Running rails commands in Docker

- `docker-compose exec ${container} ${command}`
- For example, the rails console, need to run in the container `docker-compose exec web rails c`

## Run Production locally

- add `SECRET_KEY_BASE` and `RAILS_MASTER_KEY` of the production key to docker-compose list of environment variables.
- `docker-compose -f docker-compose.yml up -d --build`
