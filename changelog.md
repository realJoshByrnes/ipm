# Changelog

## [1.0.0] - 2026-06-20

### Added
- **Core Package Manager Structure:** Created basic event handlers (`on LOAD`, `on START`) for initial load and startup feedback.
- **IRC Client Menu Integration:** Added a status MenuBar menu under "ipm" for quick access to Package Management (Add/Remove) and manual update checks.
- **Smart Self-Updater:**
  - Background auto-update check using a recurring hourly timer.
  - Implemented `If-None-Match` HTTP headers based on embedded `ETag` to support caching and avoid redundant bandwidth usage (HTTP 304 handling).
  - Added SHA1 hash validation to compare downloaded updates against local files before writing.
  - Seamless script re-loading upon successful updates.
  - Implemented AdiIRC-specific workarounds for script timers and echo commands.