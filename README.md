# SnackBox

# Setup

### Requirements

- Docker

### Steps

1. Build images `docker-compose build`
2. Run containers `docker-compose up -d`
3. Create db and run migration if not already `docker-compose run web rails db:create db:migrate`
4. Head to `localhost:3000`

## Debugging

- `docker attach snackbox_web_1` and add a `byebug` in the code to debug
- Use mailcatcher to check email content, if not already running `docker-compose up -d mailcatcher` and open `localhost:1080`

## Environment variables

- Make changes to variables with `EDITOR=vim rails credentials:edit`

## Running rails commands in Docker

- `docker-compose run ${container} ${command}`
- For example, the rails console, need to run in the container `docker-compose run web rails c`
