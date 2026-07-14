---
description: Run build_runner build and report codegen/analyzer status
---

Run `fvm dart run build_runner build` in the project root (kill any stale build_runner process and remove `.dart_tool/build/lock/build_runner.lock` first if one is already running and idle/stuck).

Then report back concisely:
- Whether the build succeeded or failed (exit code).
- Any `E` (error) lines from the build_runner output, with file:line and message.
- If there are errors, point to the exact file/line so they can be fixed — don't fix them unless asked.

Keep the report short: a status line, then a bullet per error (if any).
