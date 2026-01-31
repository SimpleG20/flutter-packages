---
description: Create and push a git tag for a specific package version
---
# Create Package Tag Workflow

This workflow automates the creation of a git tag for a specific package in the monorepo, triggering the release workflow.

## Steps

1.  **Preparation**
    - Ensure you are on the `main` branch and your working directory is clean.
    - Ensure the `version` in `pubspec.yaml` and `CHANGELOG.md` are already updated and committed.

2.  **Run Tagging Script**
    - Execute the helper script with the package name.

    ```bash
    # Usage: ./scripts/create_tag.sh <package_name>
    ./scripts/create_tag.sh {{ PACKAGE_NAME }}
    ```

    *Replace `{{ PACKAGE_NAME }}` with the actual package directory name (e.g., `router_core`, `notifications_core`).*

3.  **Verification**
    - The script will ask for confirmation to push.
    - Once pushed, verify the GitHub Actions "Release Package" workflow has started.
