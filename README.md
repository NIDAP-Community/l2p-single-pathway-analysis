# L2P Single Pathway Analysis

Portable single-comparison pathway over-representation component derived from
canonical OMIX L2P Single. It consumes a declared upstream DEG artifact, not
raw counts.

## Status

Local candidate only. The image layers the missing lockfile-pinned
`OmixPathwayInputs`, `bitops`, and `RCurl` dependencies over the immutable
OMIX pathway runtime. Canonical file-based `--custom_pathways` handling was
repaired in the locally recorded OMIX commit and is exercised by the smoke
fixture. Release and OncoChat integration remain separate gates.

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

The canonical CLI writes pathway result tables, figures when applicable, and
its CSV provenance record. `l2p_single_run_manifest.csv` is the stable
completion record. See `docs/` for the application boundary and staging
contract.
