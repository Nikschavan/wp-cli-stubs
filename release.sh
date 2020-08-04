#!/usr/bin/env bash

set -e

for V in 2.1.0  2.2.0  2.3.0  2.4.0  2.4.1; do
    echo "Releasing version ${V} ..."

    if git rev-parse "refs/tags/v${V}" >/dev/null 2>&1; then
        echo "Tag exists!"
        continue;
    fi

    # Get lock file from WP-CLI release
    wget -P "source/" "https://github.com/wp-cli/wp-cli/raw/v${V}/composer.lock"

    printf -v SED_EXP 's#\\("version"\\): "[0-9]\\+\\.[0-9]\\+\\.[0-9]\\+"#\\1: "%s"#' "$V"
    sed -i -e "$SED_EXP" source/composer.json
    composer --working-dir=source/ install --no-interaction --no-suggest

    # Generate stubs
    echo "Generating stubs ..."
    ./generate.sh

    # Tag version
    git commit --all -m "Generate stubs for WP-CLI ${V}"
    git tag "v${V}"
done