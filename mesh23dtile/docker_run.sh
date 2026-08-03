#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGE_NAME="mesh23dtile"

usage() {
  echo "Usage: $0 --input_dir <input_dir> --xml_file <xml_file> --output_dir <output_dir>"
  echo ""
  echo "  --input_dir   Directory containing the .ply files (e.g. ./maison/colorized_ply)"
  echo "  --xml_file    Path to the XML metadata file (e.g. ./maison/wasure_metadata_3d_gen.xml)"
  echo "  --output_dir  Directory where 3D Tiles output will be written"
  exit 1
}

# --- Parse arguments --------------------------------------------------------
input_dir=""
xml_file=""
output_dir=""

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --input_dir) input_dir="$2"; shift ;;
    --xml_file)  xml_file="$2";  shift ;;
    --output_dir) output_dir="$2"; shift ;;
    *) echo "Unknown parameter: $1"; usage ;;
  esac
  shift
done

if [ -z "$input_dir" ] || [ -z "$xml_file" ] || [ -z "$output_dir" ]; then
  echo "Error: Missing required parameters."
  usage
fi

# --- Resolve to absolute paths ----------------------------------------------
input_dir="$(realpath "$input_dir")"
xml_file="$(realpath "$xml_file")"
output_dir="$(realpath "$output_dir")"

mkdir -p "$output_dir"

# --- Build the image if it doesn't exist yet --------------------------------
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
  echo "Image '$IMAGE_NAME' not found, building..."
  docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
fi

# --- Run the container ------------------------------------------------------
docker run --rm \
  -v "$input_dir":/data/input:ro \
  -v "$xml_file":/data/xml_file:ro \
  -v "$output_dir":/data/output \
  "$IMAGE_NAME" \
  --input_dir /data/input \
  --xml_file /data/xml_file \
  --output_dir /data/output
