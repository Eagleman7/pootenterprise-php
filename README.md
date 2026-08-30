# pootenterprise-php

Reusable PHP 8.3 FPM image for the PootEnterprise websites.

The image is based on the PHP Docker Official Image and includes:

- PHP 8.3 FPM
- GD with FreeType and JPEG support
- MySQLi

## Published image

Images are published to GHCR after every successful merge to `main` or `master`:

```text
ghcr.io/eagleman7/pootenterprise-php:8.3-fpm-bookworm-<commit-sha>
```

Tags are immutable and there is intentionally no `latest` tag. Kubernetes workloads should reference a complete commit-specific tag so that deployments are reproducible and rollbacks are explicit.

Example:

```yaml
image: ghcr.io/eagleman7/pootenterprise-php:8.3-fpm-bookworm-0123456789abcdef0123456789abcdef01234567
```

## Development and validation

Pull requests build the image locally in GitHub Actions and verify that GD, FreeType, JPEG, and MySQLi are available and that PHP-FPM starts successfully. Pull requests do not publish images.

Dependabot checks the digest-pinned PHP base image weekly. Patch, minor, and digest updates are eligible for squash auto-merge after the required build checks pass. Major PHP updates remain manual.

Configure the active default branch (`main` currently, or `master` if you rename it) to require the **Build and test image** status check before merging. This is required for Dependabot auto-merge to wait for the image validation job.

## Rollback

Rollback by changing the deployment to a previously published commit-specific tag. No image tag is overwritten, so existing tags remain available for reproducible rollback.
