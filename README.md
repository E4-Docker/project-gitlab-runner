# GitLab Self-managed Runner Deployment for Docker Swarm

**Portainer**와 **Docker Swarm** 환경에서 **GitLab Self-managed Runner**를 **Repository** 방식으로 배포하기 위한 프로젝트 저장소입니다.

## ⚙️ 환경 변수

스택 배포 시 설정 가능한 환경 변수 목록입니다.

| 변수명 | 필수 여부 | 설명 | 기본 값 |
| :--- | :---: | :--- | :--- |
| `GITLAB_URL` | O | GitLab URL | `gitlab.example.com` |
| `TOKEN_NAME` | O | Docker Secret에 등록된 러너 토큰 이름 | `gitlab_runner_instance_alpine_token` |
| `EXECUTOR` | | GitLab Runner Executor | `docker` |
| `DOCKER_IMAGE` | | 기본 사용할 Docker 이미지 | `alpine:latest` |
| `HOSTNAME` | | GitLab Runner 이름 | `{{.Node.Hostname}}` |
| `CONCURRENT_FACTOR` | | CPU 대비 동시 작업 비율 | `1` |