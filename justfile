set dotenv-load

default:
    @just --list

install:
    pnpm install

dev: _generate-env
    pnpm dev

build:
    pnpm build

preview: _generate-env
    pnpm run preview

deploy: _generate-env
    pnpm run deploy

_generate-env:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ .env.example -nt .env ]] || [[ ! -f .env ]]; then
        echo "🔐 Injecting secrets from 1Password..."
        op inject --force -i .env.example -o .env
        echo "✅ Secrets injected"
    fi