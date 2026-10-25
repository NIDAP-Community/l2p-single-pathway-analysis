# L2P Single Pathway Analysis

Portable single-comparison pathway over-representation component derived from
canonical OMIX L2P Single. It consumes a declared upstream DEG artifact, not
raw counts.

## Status

Local candidate only. Its image correctly installs the missing pinned
`OmixPathwayInputs` dependency, but canonical file-based `--custom_pathways`
handling is currently defective; see the OMIX derivation preflight before
using or releasing this candidate.
