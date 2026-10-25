#!/usr/bin/env bash
set -euo pipefail
root="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
canonical_out="$(mktemp -d "${TMPDIR:-/tmp}/l2p-canonical.XXXXXX")"
candidate_out="$(mktemp -d "${TMPDIR:-/tmp}/l2p-candidate.XXXXXX")"
image="${1:-l2p-single-pathway-analysis:local}"
args=(--deg_table /data/deg_results.tsv --comparison Example --custom_pathways /data/custom_pathways.tsv --collections_to_include '' --minimum_number_of_deg_genes 1 --minimum_pathway_hit_count 1 --p_value_threshold_for_output 1)
docker run --rm --platform linux/amd64 --user "$(id -u):$(id -g)" --entrypoint Rscript \
  --mount "type=bind,src=${root}/test_data,dst=/data,readonly" --mount "type=bind,src=${canonical_out},dst=/output" \
  "${image}" --vanilla /app/scripts/run_l2p_single.R "${args[@]}" --output_dir /output
docker run --rm --platform linux/amd64 --user "$(id -u):$(id -g)" \
  --mount "type=bind,src=${root}/test_data,dst=/data,readonly" --mount "type=bind,src=${candidate_out},dst=/output" \
  "${image}" "${args[@]}" --output_dir /output
cmp "${canonical_out}/l2p_results.csv" "${candidate_out}/l2p_results.csv"
grep -v '"analysis_run_timestamp"' "${canonical_out}/l2p_results_provenance.csv" > "${canonical_out}/provenance_without_timestamp.csv"
grep -v '"analysis_run_timestamp"' "${candidate_out}/l2p_results_provenance.csv" > "${candidate_out}/provenance_without_timestamp.csv"
cmp "${canonical_out}/provenance_without_timestamp.csv" "${candidate_out}/provenance_without_timestamp.csv"
printf 'L2P Single canonical-output parity passed.\n'
