#!/usr/bin/env bash
set -e

# Snippets Directory
GITHUB_RAW="https://raw.githubusercontent.com"
TEXTMATE_DIR="$HOME/.config/nvim/textmate"

# Helm
#convert-snippets /dev/stdin "$SNIPS_DIR/helm.snippets" < \
#  <(curl -s "https://raw.githubusercontent.com/Azure/vscode-kubernetes-tools/master/snippets/helm.json")
#sed -i -e 's/^snippet \([a-zA-Z]\+\)\.yaml/snippet \1Yaml/g' -e 's/^snippet /snippet helm-/g' "$SNIPS_DIR/helm.snippets"

# Terraform
terraform_src='run-at-scale/vscode-terraform-doc-snippets/master/snippets/terraform.json'
# curl -s "$GITHUB_RAW/$terraform_src" | sed 's/\$/\\\\$/g' > "$TEXTMATE_DIR/terraform.json"
curl -s "$GITHUB_RAW/$terraform_src" > "$TEXTMATE_DIR/terraform.json"
