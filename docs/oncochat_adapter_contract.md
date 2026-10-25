# OncoChat Adapter Contract

Validate request fields against `schemas/interface.yml`, stage a selected DEG
artifact and any user-supplied pathway table under `/data`, and invoke a
released image by digest. Do not forward database credentials, host paths, or
arbitrary shell arguments into the container.

Consume the output only after a zero exit status and a non-empty
`l2p_single_run_manifest.csv`. The application integration must independently
approve source publication, pathway-catalog policy, and the database mapping.
