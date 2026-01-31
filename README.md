# Flutter Packages

A monorepo for shared Flutter packages.

## Packages

- **[notifications_core](./notifications_core)**: Cross-platform push notifications.
- **[router_core](./router_core)**: Decoupled navigation with GoRouter.

## Usage

To use a package in your project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  notifications_core:
    git:
      url: https://github.com/SimpleG20/flutter-packages.git
      path: notifications_core
      ref: notifications_core-v0.0.1 # Replace with latest tag
```

## Release Process

To release a new version of a package:

1. Update the `version` in `pubspec.yaml`.
2. Update `CHANGELOG.md`.
3. Commit the changes.
4. Create a tag in the format `package_name-vX.Y.Z` (e.g., `notifications_core-v0.0.1`).
5. Push the tag: `git push origin --tags`.

A GitHub Action will automatically create a release for the tag.