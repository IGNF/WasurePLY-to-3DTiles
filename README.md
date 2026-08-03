# WasurePLY-to-3DTiles

Independent brick, based on `py3dtilers`, to convert `.ply` files from `sparkling-Wasure` to 3D Tiles.
The folder `mesh23dtile` is from the repo [sparkling-wasure](https://github.com/lcaraffa/sparkling-wasure) and contains the code to convert `.ply` files to 3D Tiles. This repo only adds a Dockerfile with a building script and a running script to make it easier to use.

## License

This project is distributed under the **GNU AFFERO GENERAL PUBLIC LICENSE (AGPL v3.0)**.

## Usage (Docker)

### 1. Build the image

```bash
cd mesh23dtile
./build.sh
```

This builds a Docker image named `mesh23dtile:latest`.

### 2. Run the pipeline

```bash
cd mesh23dtile
./docker_run.sh --input_dir <input_dir> --xml_file <xml_file> --output_dir <output_dir>
```

| Argument | Description |
|---|---|
| `--input_dir` | Directory containing the `.ply` files |
| `--xml_file` | Path to the Wasure XML metadata file (`wasure_metadata_3d_gen.xml`) |
| `--output_dir` | Directory where the 3D Tiles output will be written |

Example:

```bash
./docker_run.sh \
  --input_dir ./wasure_output/outputs/tiles \
  --xml_file ./wasure_output/wasure_metadata_3d_gen.xml \
  --output_dir ./wasure_output/LODs
```

The output directory will contain a `tileset.json` ready to be served and visualized in a 3D Tiles viewer (e.g. Cesium, iTowns), associated with a LODs folder containing the `.b3dm` tiles.

## Input and output conventions

**Input:**
- A directory of a folder which contains `.ply` mesh files.
- A Wasure XML metadata file providing the bounding box origin (`<bbox_ori>`), used to compute the geographic offset.

**Output:**
- A 3D Tiles tileset (`tileset.json` + `.b3dm` tiles) in EPSG:4978 (geocentric), suitable for web-based 3D visualization.
