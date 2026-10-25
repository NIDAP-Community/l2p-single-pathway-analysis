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
