# Architecture

`scripts/run_l2p_single.R` and `R/L2P_Analysis.R` are preserved canonical OMIX
science. `entrypoint.R` invokes that CLI unchanged and copies completed
artifacts into a stable result bundle. The image layers only the
lockfile-pinned runtime dependencies omitted from the shared pathway image:
`OmixPathwayInputs`, `bitops`, and `RCurl`.

The custom-pathway file reader is a locally committed canonical OMIX repair;
its source commit and byte hashes are recorded in `OMIX_MODULE_SOURCE.md`.
Callers stage a bounded DEG table and optional pathway table under `/data`; the
container writes only to `/output`.
