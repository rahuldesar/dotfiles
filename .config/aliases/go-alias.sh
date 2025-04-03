goinit() {
  GH_PROFILE=$(gh api user --jq '.html_url | sub("https://"; "")')
  MODULE_NAME="$GH_PROFILE/$(basename $(pwd))"
  echo "alias: go mod init $MODULE_NAME"
  go mod init "$MODULE_NAME" &&
    touch README.md &&
    mkdir -p ./cmd/main && touch ./cmd/main/main.go &&
    echo "# $MODULE_NAME" >>README.md &&
    git init &&
    git add . &&
    mkdir -p ./internal/module1 && touch ./internal/module1/module1.go &&
    git commit -m "Initial commit: go mod init $GH_PROFILE/$(basename $(pwd))"
}
