# L2P Single Pathway Analysis

Portable single-comparison pathway over-representation component derived from
canonical OMIX L2P Single. It consumes a declared upstream DEG artifact, not
raw counts.

## Input and output

Stage one validated DEG table, and optionally a custom pathway table, read-only
under `/data`.

```bash
docker run --rm --platform linux/amd64 \
  -v "$PWD/input:/data:ro" -v "$PWD/results:/output" \
  l2p-single-pathway-analysis:local \
  --deg_table /data/deg_results.tsv --comparison Example \
  --custom_pathways /data/custom_pathways.tsv \
  --collections_to_include '' --output_dir /output
```

The canonical root outputs are retained for command-line compatibility. The
tool also copies pathway tables to `tables/`, figures to `figures/`, logs to
`logs/`, and writes `RUN_METADATA.md` plus `run_manifest.json`.
