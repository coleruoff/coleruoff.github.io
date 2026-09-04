#!/bin/bash

set -e

ARTICLES_DIR="$(cd "$(dirname "$0")" && pwd)"

find "$ARTICLES_DIR" -mindepth 2 -maxdepth 2 -name "*.qmd" -print0 |
while IFS= read -r -d '' qmd; do

    ARTICLE_DIR="$(dirname "$qmd")"
    QMD_FILE="$(basename "$qmd")"
    HTML_FILE="${QMD_FILE%.qmd}.html"

    echo "Rendering: $qmd"

    cd "$ARTICLE_DIR"

    quarto render "$QMD_FILE" \
        --to html \
        --output "$HTML_FILE" \
        --no-project

done

echo "Finished rendering all articles."