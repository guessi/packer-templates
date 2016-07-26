#!/bin/bash

set -e

INPUT="$1"

if [ ! -f "${INPUT}" ]; then
  echo "input file not exist"
  exit 1
fi

virt-sparsify --check-tmpdir continue --convert qcow2 ${INPUT} ${INPUT}.sparsify
qemu-img convert -c -p -f qcow2 -O qcow2 ${INPUT}.sparsify ${INPUT}

rm -vf ${INPUT}.sparsify

chmod 0640 ${INPUT}
