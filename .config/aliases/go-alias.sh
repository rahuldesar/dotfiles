# NOTE: Dont forget to source after changing this file

goinit() {
  GH_PROFILE=$(gh api user --jq '.html_url | sub("https://"; "")')
  MODULE_NAME="$GH_PROFILE/$(basename $(pwd))"
  echo "alias: go mod init $MODULE_NAME"
  go mod init "$MODULE_NAME" &&
    touch README.md &&
    touch main.go &&
    mkdir -p ./cmd && echo "package cmd" >>./cmd/command.go &&
    echo "# $MODULE_NAME" >>README.md &&
    git init &&
    air init &&
    cp "$HOME/.config/templates/gitignore/go.gitignore" ./.gitignore &&
    git add . &&
    touch .env &&
    mkdir -p ./internal/module1 && touch ./internal/module1/module1.go &&
    cp "$HOME/.config/templates/readme/go/interal.md" ./internal/README.md &&
    git commit -m "Initial commit: go mod init $GH_PROFILE/$(basename $(pwd))"
}
