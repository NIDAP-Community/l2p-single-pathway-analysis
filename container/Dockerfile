# syntax=docker/dockerfile:1
ARG BASE_IMAGE=ghcr.io/nidap-community/omix-r-pathway@sha256:25ad9f50df5a4d7f70a7e3debed13f8d5c9b07cbc46d57fdf5c3cf4f2e767ddc
FROM ${BASE_IMAGE}
WORKDIR /app
COPY R/ R/
COPY scripts/ scripts/
COPY schemas/ schemas/
COPY packages/ packages/
COPY test_data/ test_data/
COPY vendor/ vendor/
COPY module.yml renv.lock ./
RUN echo 'cff3a5b77b72bb3b8fde92b690d0f803466d218a3ead6b731ae7c77ac1740d08  vendor/bitops_1.0-9.tar.gz' | sha256sum --check - \
 && R CMD INSTALL vendor/bitops_1.0-9.tar.gz \
 && echo '57300322f0da21deef5094f12b4a7a94834e60262859e5afb5ff16ac7d431205  vendor/RCurl_1.98-1.19.tar.gz' | sha256sum --check - \
 && R CMD INSTALL vendor/RCurl_1.98-1.19.tar.gz \
 && Rscript --vanilla -e 'if (!requireNamespace("RCurl", quietly = TRUE)) stop("RCurl installation failed")' \
 && R CMD INSTALL packages/OmixPathwayInputs \
 && mkdir -p /data /output \
 && useradd --create-home --uid 10001 --shell /usr/sbin/nologin l2p \
 && chown --recursive l2p:l2p /app /data /output
USER l2p
ENTRYPOINT ["Rscript", "--vanilla", "/app/scripts/run_l2p_single.R"]
CMD ["--help"]
