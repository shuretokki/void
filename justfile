set windows-shell := ["powershell.exe", "-NoProfile", "-Command"]

project_name := "void"
node_bin := "./node_modules/.bin/"
setup_env := if path_exists(".env") == "true" { "echo '.env exists'" } else { "cp .env.example .env" }

# list all available commands
default:
    @just --list

# initialize the project and install all dependencies
setup:
    @echo "setting up {{project_name}}..."
    {{ setup_env }}
    pnpm install

# start the development server
dev:
    pnpm dev

# start development and clean cache
clean-dev:
    pnpm nuxi clean
    pnpm dev

# run all checks
check:
    pnpm lint
    pnpm nuxi typecheck

# format all files (using pnpm/eslint/prettier for cross-platform support)
fmt:
    pnpm exec eslint --fix .

# build the project for production
build:
    NODE_OPTIONS="--max-old-space-size=4096" pnpm build

# deploy the production build to cloudflare pages
deploy: build
    npx -y wrangler pages deploy dist

preview: build
    npx -y wrangler pages dev dist

# watch and live-preview typst
watch target="README":
    typst-live {{target}}.typ

# create a new local migration file from schema
migration:
    pnpm drizzle-kit generate

# apply migrations to local development database
migrate:
    npx -y wrangler d1 migrations apply {{project_name}} --local

# apply migrations to production (live) database
migrate-prod:
    npx -y wrangler d1 migrations apply {{project_name}} --remote

# compile and optimize readme images
readme:
    typst compile --font-path ./docs/fonts --input theme=dark docs/README.typ docs/readme-dark.png
    typst compile --font-path ./docs/fonts --input theme=light docs/README.typ docs/readme-light.png
    oxipng -o 4 --strip all docs/readme-dark.png docs/readme-light.png
