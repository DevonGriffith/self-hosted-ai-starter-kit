### add_license_to_repo.sh
### Created on 2025-06-04
### Created and Owned by Devon Griffith

#!/bin/bash

LICENSE_TEXT='
Copyright (c) 2025 Devon Griffith. All rights reserved.

## Intellectual Property
All code, binaries, and documentation in this repository are the exclusive property of Devon Griffith. This software is proprietary and confidential. No portion of this software is licensed for use except as explicitly agreed in writing by the owner. The software and its source code are protected under copyright law and international treaties.

## Restrictions
No rights or license are granted by this notice. Without the owner’s prior *explicit written permission*, you may **not** use, copy, modify, distribute, sublicense, or create derivative works of this software in any form. In particular, you may **not** reverse-engineer, decompile, or disassemble any portion of the software. Any unauthorized use of the contents of this repository is strictly prohibited.

## Licensing Terms
Anyone wishing to use or incorporate this software must obtain a separate license agreement directly from the owner. Contact Devon Griffith to negotiate licensing terms and obtain written permission. No other use is authorized by this license.

## Disclaimer of Warranty and Liability
This software is provided *“AS IS”* and without any warranty, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement. In no event will the author or copyright holder be liable for any damages arising out of the use or inability to use this software, even if advised of the possibility of such damage.

## Governing Law
This license is governed by the laws of Ontario, Canada (the owner’s jurisdiction) and by applicable international copyright treaties.

## Contact
For licensing inquiries or written permission, please contact Devon Griffith through his GitHub profile or provided contact information. All terms of use must be negotiated and agreed in writing with the owner before any use of this software.
'

insert_license() {
  local target_dir="$1"
  local license_path="$target_dir/LICENSE.md"

  if [[ -f "$license_path" ]]; then
    echo "[SKIP] LICENSE.md already exists in $target_dir"
  else
    echo "$LICENSE_TEXT" > "$license_path"
    echo "[OK] LICENSE.md added to $target_dir"
  fi
}

update_readme() {
  local target_dir="$1"
  local readme_path="$target_dir/README.md"

  if [[ ! -f "$readme_path" ]]; then
    echo "[INFO] README.md not found in $target_dir – skipping README update"
    return
  fi

  grep -q "## License" "$readme_path" && {
    echo "[SKIP] README already contains license section"
    return
  }

  echo -e "\n## License\nThis repository is governed by the [Devon Griffith Proprietary License](LICENSE.md). All rights reserved." >> "$readme_path"
  echo "[OK] README.md license section appended"
}

main() {
  if [[ -z "$1" ]]; then
    echo "Usage: $0 /path/to/repo1 [/path/to/repo2 ...]"
    exit 1
  fi

  for repo in "$@"; do
    echo "Processing $repo..."
    if [[ ! -d "$repo" ]]; then
      echo "[ERROR] $repo is not a directory"
      continue
    fi
    insert_license "$repo"
    update_readme "$repo"
  done
}

main "$@"