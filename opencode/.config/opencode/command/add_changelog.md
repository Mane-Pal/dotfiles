---
description: Adds changelog entries for the GameScanner repo 
agent: build
---
Check the diff against origin/master to figure out what changes  there is made on this PR. when running git diff use git --no-pager flag.

Add change log entrie(s) to file services/CHANGELOG.MD

Everything in CHANGELOG.MD is customer facing, so only add changes that customer should see and use.

Dont refer to the operators as plural, speak to them directly

format of changelog:

All notable changes to the commonly shared code will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

The common changelog will use datestamps as entries, and we will adhere to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) in the generated operator_specific changelog.

The format for the changelog can be seen below.

- [Date `## heading 2`]
  - Added `### heading 3`
    - New features that have been implemented but not yet released.
  - Changed `### heading 3`
    - Changes in existing functionality.
  - Deprecated `### heading 3`
    - Features that will be removed in a future release.
  - Removed `### heading 3`
    - Features that have been removed in this release.
  - Fixed `### heading 3`
    - Bug fixes that have been applied.
  - Security `### heading 3`
    - Security-related changes or improvements.
  - Optimizations `### heading 3`
    - Changes that are general optimizations that improves the performance or stability.
  - Requires action `### heading 3`
    - Changes that might force an action on the Operator side.

The entry format is: `- [Tag]:version_type Description`

**Allowed Tags:**

- [Analytics] - Changes to analytics service
- [API] - Changes to API service
- [DB] - Database schema or migration changes
- [GameScanner] - Changes to GameScanner service
- [General] - General infrastructure or cross-service changes
- [Preprocessor] - Changes to data preprocessing service

**Allowed version_types:**

- `major` - Major feature additions or model upgrades
- `minor` - New features, significant improvements or breaking changes
- `patch` - Bug fixes or minor updates

example:

## [2025-11-27]

### Added

- [Analytics]:patch Added a filtering option in the Account Info filter on Analysis View that allows the user to filter on a player's account status.

### Changed

- [Preprocessor]:patch If the `ACTUAL_CURRENCY` setting is set, the preprocessor will fill missing currency values for the `personal_data.currency` and `customer_data.currency` columns with this value during preprocessing.
