# pootenterprise-php

Reusable PHP 8.5 FPM image for the PootEnterprise websites.

The image is based on the PHP Docker Official Image and includes:

- PHP 8.5 FPM
- GD with FreeType and JPEG support
- MySQLi

## Published image

Images are published to GHCR after every merge to `main` that changes the `Dockerfile` or the build workflow:

```text
ghcr.io/eagleman7/pootenterprise-php:8.5-fpm-bookworm-<commit-sha>
```

Tags are immutable and there is intentionally no `latest` tag. Kubernetes workloads should reference a complete commit-specific tag so that deployments are reproducible and rollbacks are explicit.

Example:

```yaml
image: ghcr.io/eagleman7/pootenterprise-php:8.5-fpm-bookworm-0123456789abcdef0123456789abcdef01234567
```

## Development and validation

Pull requests build the image locally in GitHub Actions and verify that GD, FreeType, JPEG, and MySQLi are available and that PHP-FPM starts successfully. Pull requests do not publish images.

Dependabot checks the digest-pinned PHP base image daily. The PHP image is excluded from Dependabot's default 3-day cooldown, because the official image tags are rebuilt so often that the cooldown would otherwise keep holding back security rebuilds. Dependabot opens a pull request for each patch, minor, or digest update; these are never merged automatically. Merge them manually once the build checks pass: the resulting push to `main` triggers the build that publishes the new image. Major PHP updates remain manual.

Configure the active default branch (`main` currently, or `master` if you rename it) to require the **Build and test image** status check before merging, so an update that fails the image validation job cannot be merged.

## Rollback

Rollback by changing the deployment to a previously published commit-specific tag. No image tag is overwritten, so existing tags remain available for reproducible rollback.
