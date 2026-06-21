# Django Notes App Deployment Script

This project contains a bash script to deploy a Python Django notes application into a Docker container.

## What it does

The script `deploy-python-script.sh` performs the following steps:
- clones the `django-notes-app` repository from GitHub if it does not already exist
- installs `nginx` and `docker-compose` using `yum` if they are not already installed
- restarts `nginx` and `docker` services
- builds a Docker image for the notes application
- starts the application using `docker-compose up -d`

## Prerequisites

The script expects:
- a Yum-based Linux distribution (e.g. CentOS, RHEL, Amazon Linux)
- `systemd` service management (`systemctl` available)
- root or sudo privileges to install packages and restart services
- network access to `https://github.com/LondheShubham153/django-notes-app.git`

## Usage

From the `PROJECT-1` directory, run:

```bash
bash deploy-python-script.sh
```

If the repository already exists, the script will skip cloning and continue from the repository directory.

## Important notes

- The script installs `nginx` and `docker-compose` only if they are missing.
- It uses `yum` as the package manager, so it is not portable to Debian/Ubuntu without modification.
- The script assumes the cloned repo contains a valid `Dockerfile` and `docker-compose.yml`.
- If any step fails, the script exits with a failure message.

## File location

- `deploy-python-script.sh` — deployment script

## Recommended improvements

- add validation for `docker` installation
- support non-`yum` package managers
- add error logging and retry logic
- verify `docker-compose.yml` exists before deployment
