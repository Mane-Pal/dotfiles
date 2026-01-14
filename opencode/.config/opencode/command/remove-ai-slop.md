
---
description: Removes AI slop from your branch
agent: build
---

# Remove AI code slop

Check the diff against origin/master, and remove all AI generated slop introduced in this branch.

when running git diff use git --no-pager flag

This includes:

- Extra comments that a human wouldn't add or is inconsistent with the rest of the file
- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
- Casts to any to get around type issues
- Any other style that is inconsistent with the file
- Any missing type annotations

Report at the end with only a 1-3 sentence summary of what you changed
