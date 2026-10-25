#!/usr/bin/env Rscript

# Application adapter: invoke the byte-preserved OMIX CLI, then copy (never
# rewrite) its completed artifacts into a stable result bundle.
args <- commandArgs(trailingOnly = TRUE)
canonical_script <- file.path("scripts", "run_l2p_single.R")

option_value <- function(name, values) {
  index <- which(values == name)
  if (length(index) == 1L && index < length(values)) return(values[[index + 1L]])
  prefix <- paste0(name, "="); inline <- values[startsWith(values, prefix)]
  if (length(inline) == 1L) substring(inline, nchar(prefix) + 1L) else NULL
}

write_bundle <- function(output_dir, arguments) {
  artifacts <- data.frame(
    role = c("Pathway result table", "Canonical provenance table", "Canonical run manifest"),
    source = c("l2p_results.csv", "l2p_results_provenance.csv", "l2p_single_run_manifest.csv"),
    destination = c("tables/l2p_results.csv", "tables/l2p_results_provenance.csv", "logs/l2p_single_run_manifest.csv"),
    stringsAsFactors = FALSE
  )
  if (!all(file.exists(file.path(output_dir, artifacts$source)))) stop("Canonical L2P run did not create all required artifacts.")
  figures <- list.files(output_dir, pattern = "^l2p_plots_.*\\.png$", full.names = FALSE)
  if (length(figures) > 0L) {
    artifacts <- rbind(artifacts, data.frame(role = rep("Pathway figure", length(figures)), source = figures, destination = file.path("figures", figures), stringsAsFactors = FALSE))
  }
  for (directory in unique(dirname(artifacts$destination))) dir.create(file.path(output_dir, directory), recursive = TRUE, showWarnings = FALSE)
  for (i in seq_len(nrow(artifacts))) file.copy(file.path(output_dir, artifacts$source[[i]]), file.path(output_dir, artifacts$destination[[i]]), overwrite = TRUE)
  capture.output(sessionInfo(), file = file.path(output_dir, "logs", "sessionInfo.txt"))
  timestamp <- format(Sys.time(), tz = "UTC", usetz = TRUE)
  manifest <- list(status = "completed", completed_utc = timestamp,
    canonical_omix_module = "OMIX-L2P-Single", artifacts = lapply(seq_len(nrow(artifacts)), function(i) list(role = artifacts$role[[i]], path = artifacts$destination[[i]])),
    arguments = arguments)
  jsonlite::write_json(manifest, file.path(output_dir, "run_manifest.json"), auto_unbox = TRUE, pretty = TRUE)
  writeLines(c("# L2P Single Run Metadata", "", "Completed successfully.", "", "## Canonical module", "", "OMIX-L2P-Single", "", "## Parameters", "", paste0("`", paste(arguments, collapse = " ` `"), "`"), "", "Exploratory research use only; not clinical decision support."), file.path(output_dir, "RUN_METADATA.md"))
}

status <- system2(file.path(R.home("bin"), "Rscript"), c("--vanilla", shQuote(canonical_script), shQuote(args)))
output_dir <- option_value("--output_dir", args)
if (identical(as.integer(status), 0L) && !is.null(output_dir)) write_bundle(output_dir, args)
quit(save = "no", status = as.integer(status))
