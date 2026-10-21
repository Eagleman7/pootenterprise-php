# pootenterprise-php

Reusable PHP 8.5 FPM image for the PootEnterprise websites.

The image is based on the PHP Docker Official Image and includes:

- PHP 8.5 FPM
- GD with FreeType and JPEG support
- MySQLi

## Published image

Images are published to GHCR after every merge to `main` that changes the `Dockerfile` or the build workflow:

```text
ghcr.io/eagleman7/pootenterprise-php:<php-version>-<commit-sha>
```

`<php-version>` is the exact PHP version of the base image in the `Dockerfile`'s `FROM` line, which must therefore pin a full `php:X.Y.Z-*` tag. The build fails if it does not, or if the built image reports a different PHP version.

Commit-specific tags are immutable. Each build is also tagged with the bare PHP version (for example `8.5.12`), which moves to the newest build of that version. There is intentionally no `latest` tag.

Kubernetes workloads reference the PHP version tag pinned to a digest, so deployments stay reproducible while Renovate can propose updates: a new digest when the same PHP version is rebuilt (for example for base image security fixes), and a new tag when a newer PHP version is published.

Example:

```yaml
image: ghcr.io/eagleman7/pootenterprise-php:8.5.12@sha256:0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef
```

After each published image, the workflow creates a GitHub release with the same name as the image tag. The release notes list the image reference, its digest, the base image, and the changes merged since the previous release.

## Development and validation

Pull requests build the image locally in GitHub Actions and verify that GD, FreeType, JPEG, and MySQLi are available and that PHP-FPM starts successfully. Pull requests do not publish images.

Dependabot checks the digest-pinned PHP base image daily. The PHP image is excluded from Dependabot's default 3-day cooldown, because the official image tags are rebuilt so often that the cooldown would otherwise keep holding back security rebuilds. Dependabot opens a pull request for each patch, minor, or digest update; these are never merged automatically. Merge them manually once the build checks pass: the resulting push to `main` triggers the build that publishes the new image. Major PHP updates remain manual.

Configure the active default branch (`main` currently, or `master` if you rename it) to require the **Build and test image** status check before merging, so an update that fails the image validation job cannot be merged.

## Rollback

Rollback by changing the deployment's digest to a previous build's digest, which is listed in that build's GitHub release, or to a previously published commit-specific tag. Commit-specific tags and digests are never overwritten, so earlier builds remain available for reproducible rollback.
