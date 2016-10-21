pkg_name=sentry
pkg_description="Sentry is a modern error logging and aggregation platform."
pkg_upstream_url=https://sentry.io
pkg_origin=mediatemple
pkg_version=8.9.0
pkg_maintainer="George Marshall <gmarshall@mediatemple.net>"
pkg_license=('BSD-3-Clause')
pkg_source=nosuchfile.tgz
pkg_deps=(
    # Missing Pillow deps
    # *** OPENJPEG (JPEG2000) support not available
    # *** LITTLECMS2 support not available
    core/freetype/2.6.3/20160729201535
    core/libffi
    core/libjpeg-turbo
    core/libtiff
    core/libwebp
    core/openssl/1.0.2j/20160926152543
    core/postgresql
    core/python2
    core/zlib/1.2.8/20160612064520
)
pkg_build_deps=(
    core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
    pip install --upgrade setuptools pip wheel virtualenv

    # Workaround for cryptography library not properly resolving cffi
    pip install cffi
}

do_build() {
    pip wheel --wheel-dir="$HAB_CACHE_SRC_PATH/wheelhouse" \
        "sentry==$pkg_version"
}

do_install() {
    virtualenv ${pkg_prefix}
    ${pkg_prefix}/bin/pip install --no-index \
        --find-links="$HAB_CACHE_SRC_PATH/wheelhouse" \
        "sentry==$pkg_version"
   # Write out versions of all pip packages to package
    ${pkg_prefix}/bin/pip freeze > "$pkg_prefix/requirements.txt"
}

do_strip() {
    ${pkg_prefix}/bin/pip uninstall --yes pip wheel
}
