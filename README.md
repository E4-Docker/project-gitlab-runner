# 🐳 GitLab Self-managed Runner Deployment Repository

이 저장소는 **Docker Compose** 또는 **Docker Swarm**을 사용하여 **GitLab Self-managed Runner**를 배포하기 위한 설정 파일들을 제공합니다.

## 🛠️ 사전 준비

### Windows

1. **PowerShell 관리자 권한 실행** 후 다음 명령어 입력

    ```powershell
    # gitlab-runner 프로젝트 폴더 생성
    New-Item -Path "C:\ProgramData\Docker\secrets\gitlab-runner" -ItemType Directory

    # pwsh 컨테이너용 러너 토큰 파일 생성
    New-Item -Path "C:\ProgramData\Docker\secrets\gitlab-runner\runner_token_pwsh.txt" -ItemType File -Value "your_token_pwsh"

    # powershell 컨테이너용 러너 토큰 파일 생성
    New-Item -Path "C:\ProgramData\Docker\secrets\gitlab-runner\runner_token_powershell.txt" -ItemType File -Value "your_token_powershell"
    ```

2. **GitLab**에서 **Runner** 2개 생성

- Runner #1
  - 태그: `windows`, `pwsh`
- Runner #2
  - 태그: `windows`, `powershell`

## 🚀 배포 방법

### 1. Linux

#### Docker Swarm

```bash
curl -L https://raw.githubusercontent.com/E4-Docker/project-gitlab-runner/refs/heads/main/docker-stack.yml | docker stack deploy -c - gitlab-runner
```

### 2. Windows

#### Docker Compose

```powershell
$env:GITLAB_URL="https://gitlab.example.com"; Invoke-RestMethod -Uri "https://raw.githubusercontent.com/E4-Docker/project-gitlab-runner/refs/heads/main/windows/docker-compose.yml" | docker-compose -f - -p gitlab-runner up -d
```

## 🧹 정리 방법

### Linux & Windows

#### Docker Compose
```powershell
docker compose -p gitlab-runner down
```

#### Docker Swarm

```powershell
docker stack rm gitlab-runner
```

## ⚙️ 환경 변수

### 1. Linux

| 변수명 | 필수 여부 | 설명 | 기본 값 |
| :--- | :---: | :--- | :--- |
| `GITLAB_URL` | O | GitLab URL | `gitlab.example.com` |
| `TOKEN_NAME` | O | Docker Secret에 등록된 러너 토큰 이름 | `gitlab_runner_instance_alpine_token` |
| `EXECUTOR` | | GitLab Runner Executor | `docker` |
| `DOCKER_IMAGE` | | 기본 사용할 Docker 이미지 | `alpine:latest` |
| `HOSTNAME` | | GitLab Runner 이름 | `{{.Node.Hostname}}` |
| `CONCURRENT_FACTOR` | | CPU 대비 동시 작업 비율 | `1` |

### 2. Windows

| 변수명 | 필수 여부 | 설명 | 기본 값 |
| :--- | :---: | :--- | :--- |
| `GITLAB_URL` | O | GitLab URL | `gitlab.example.com` |
| `TOKEN_NAME` | | 러너 토큰 파일 이름 | `runner_token` |
| `EXECUTOR` | | GitLab Runner Executor | `docker-windows` |
| `DOCKER_IMAGE` | | 기본 사용할 Docker 이미지 | `mcr.microsoft.com/powershell:nanoserver-ltsc2022`, `mcr.microsoft.com/windows/servercore:ltsc2022` |
| `HOSTNAME` | | GitLab Runner 이름 | `$env:COMPUTERNAME-pwsh`, `$env:COMPUTERNAME-powershell` |
| `CONCURRENT_FACTOR` | | CPU 대비 동시 작업 비율 | `0.25` |