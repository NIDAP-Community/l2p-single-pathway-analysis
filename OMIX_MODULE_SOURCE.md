# Canonical source

`OMIX-L2P-Single` base source commit: `0ea6223129de6d98d69469027c19fa1887b59f6a`;
local canonical CLI fix commit: `0b2fe11`.
Module version/interface: `3.3.0` / `1`.

| File | SHA-256 |
| --- | --- |
| `R/L2P_Analysis.R` | `f24c57751dcbda394cdf222bdf46892b6f463f98fb678d07234e921fa0c02054` |
| `scripts/run_l2p_single.R` | `0d96fa74049692401665265e6bee6b69fa2826a65461929cef544949eb62e701` |
| `schemas/interface.yml` | `1b9575f6573be628f8b1860c3961601541fd4c3818cd94193a59d1631de7342d` |

Runtime base: `ghcr.io/nidap-community/omix-r-pathway@sha256:25ad9f50df5a4d7f70a7e3debed13f8d5c9b07cbc46d57fdf5c3cf4f2e767ddc` plus the pinned `OmixPathwayInputs` 0.1.0 source overlay.

The application also vendors lockfile-pinned `bitops` 1.0-9 (SHA-256
`cff3a5b77b72bb3b8fde92b690d0f803466d218a3ead6b731ae7c77ac1740d08`) and
`RCurl` 1.98-1.19 as
`vendor/RCurl_1.98-1.19.tar.gz` (SHA-256
`57300322f0da21deef5094f12b4a7a94834e60262859e5afb5ff16ac7d431205`),
because the shared runtime omits it and Docker's CRAN TLS chain is not trusted
in this environment.
