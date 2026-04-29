#!/bin/sh

echo 'Registering new GitLab Runner...'

gitlab-runner register \
    --non-interactive \
    --url $GITLAB_URL \
    --token $(cat /run/secrets/token) \
    --executor $EXECUTOR \
    --docker-image $DOCKER_IMAGE

# concurrent 설정
sed -i "s/^concurrent = .*/concurrent = $CONCURRENT/" /etc/gitlab-runner/config.toml

# request_concurrency 설정
if grep -q "request_concurrency" /etc/gitlab-runner/config.toml; then
    sed -i "s|^request_concurrency = .*|request_concurrency = $CONCURRENT|" /etc/gitlab-runner/config.toml
else
    sed -i "2i request_concurrency = $CONCURRENT" /etc/gitlab-runner/config.toml
fi