#!/usr/bin/env bash
set -euo pipefail
script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(CDPATH= cd -- "${script_dir}/.." && pwd)"
output_dir="$(mktemp -d "${TMPDIR:-/tmp}/l2p-single-smoke.XXXXXX")"
docker run --rm --platform linux/amd64 --user "$(id -u):$(id -g)" \
  --mount "type=bind,src=${project_dir}/test_data,dst=/data,readonly" \
  --mount "type=bind,src=${output_dir},dst=/output" "${1:-l2p-single-pathway-analysis:local}" \
  --deg_table /data/deg_results.tsv --comparison Example --custom_pathways /data/custom_pathways.tsv \
  --collections_to_include '' --minimum_number_of_deg_genes 1 --minimum_pathway_hit_count 1 \
  --p_value_threshold_for_output 1 --output_dir /output
test -s "${output_dir}/l2p_single_run_manifest.csv"
test -s "${output_dir}/l2p_results.csv"
test -s "${output_dir}/l2p_results_provenance.csv"
printf 'L2P Single container smoke test passed: %s\n' "${output_dir}"
