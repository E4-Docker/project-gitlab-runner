#!/bin/sh

if [ ! -f /etc/gitlab-runner/config.toml ]; then
    echo 'Registering new GitLab Runner...'

    gitlab-runner register \
    --non-interactive \
    --url $GITLAB_URL \
    --token $(cat /run/secrets/token) \
    --executor $EXECUTOR \
    --docker-image $DOCKER_IMAGE

    sed -i "s/^concurrent = .*/concurrent = $CONCURRENT/" /etc/gitlab-runner/config.toml
else
    echo 'Runner is already registered.'
fi