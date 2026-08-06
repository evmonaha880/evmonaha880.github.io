#!/bin/bash
# Regenerate files/resume.pdf from resume.html.
# The print rules live in the @media print block of style.css; the résumé is
# tuned to land on exactly one page. Re-run this after any résumé edit.
set -euo pipefail
cd "$(dirname "$0")"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="files/resume.pdf" "file://$PWD/resume.html" >/dev/null 2>&1

PAGES=$(~/DataLake/.venv/bin/python -c "import fitz;print(fitz.open('files/resume.pdf').page_count)")
echo "files/resume.pdf regenerated: ${PAGES} page(s)"
[ "$PAGES" = "1" ] || { echo "FAIL: résumé must be one page"; exit 1; }
