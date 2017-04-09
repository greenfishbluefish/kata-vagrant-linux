#!/bin/bash

# Notes:
#   * This script (like all provisioners) runs as root. So, no need to "sudo".
#   * All actions in this script are idempotent. This means the same end result
#     no matter how many times it is run. q.v. README.md for more discussion.

# Use good Bash practices. For more information, q.v.
#   * https://google.github.io/styleguide/shell.xml
set -eu

echo "script1 ran"
