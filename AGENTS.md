# AGENTS.md

This repository contains the snap packaging (and colocated YARF UI tests) for
the **thrive** snap, published by kenvandine.

## Automated maintenance

This repository is maintained in part by the `automated-ken` fleet-maintenance
system (https://github.com/kenvandine/automated-ken). Automated agents may:

- Open pull requests bumping the packaged application/runtime version
- Queue YARF UI test runs on a registered remote runner (real hardware polling the
  automated-ken dashboard for jobs) against candidate/edge builds before promoting a
  release
- Review and comment on PRs, including AI-assisted screenshot review of UI test
  results

## Tests

YARF UI test suites belong under `tests/suite/` in this repository. They are
executed by a registered remote runner (physical/real hardware enrolled with the
automated-ken dashboard), which polls the dashboard for queued jobs, downloads/
installs the target snap build, runs the YARF suite locally, and uploads
screenshots/results directly back to the dashboard. No GitHub Actions workflow is
involved in running tests.

## Conventions

- Do not remove the `tests/suite/` directory; it is required for automated release
  validation. There is no test-running GitHub Actions workflow in this repo by
  design — tests run on a registered remote runner.
- Redundant upstream-polling / sync-release workflows that duplicate automated-ken's
  own version-bump automation should be removed to avoid conflicting/duplicate PRs.

## Upstream release detection

Upstream releases live at
`https://github.com/Revolutionary-Games/Thrive/releases`. This repo's
`source:` is a full release-asset download URL
(`https://github.com/Revolutionary-Games/Thrive/releases/download/v$SNAPCRAFT_PROJECT_VERSION/...`),
not a bare repo URL, so `owner/repo` must be matched anywhere in the
path (not just at the very end of the string) to correctly infer
`Revolutionary-Games/Thrive` as the upstream slug.

To check for a new version:

- Query `https://api.github.com/repos/Revolutionary-Games/Thrive/releases/latest`
  (excludes drafts/prereleases) and strip the leading `v` from
  `tag_name`.
- Compare against the top-level `version:` field in `snap/snapcraft.yaml`
  and update it directly if different.
