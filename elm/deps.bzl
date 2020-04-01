load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")

def elm_register_toolchains():
    _http_archive(
        name = "com_github_elm_compiler_linux",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "7c91e72e275045dac98aab8a29b539a63085bfff859f6f3fa759982bed817909",
        urls = ["https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz"],
    )

    _http_archive(
        name = "com_github_elm_compiler_mac",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "ce73ae6a5870a99ecaacfae84b661d4e211c634324d278f2b10f76f6c5e3b16b",
        urls = ["https://github.com/elm/compiler/releases/download/0.19.1/binary-for-mac-64-bit.gz"],
    )

    _http_archive(
        name = "com_github_rtfeldman_node_test_runner",
        build_file_content = """load("@com_github_edschouten_rules_elm//elm:def.bzl", "elm_library")

elm_library(
    name = "node_test_runner",
    srcs = glob(["src/**/*.elm"]),
    strip_import_prefix = "src",
    visibility = ["//visibility:public"],
)""",
        sha256 = "ecfefe7a4ad740b37e5edc85716cc4d7eb7a63d1d25b315902e869251f4ebe00",
        strip_prefix = "node-test-runner-0.19.1",
        urls = ["https://github.com/rtfeldman/node-test-runner/archive/0.19.1.tar.gz"],
    )

    native.register_toolchains("@com_github_edschouten_rules_elm//elm/toolchain:linux")
    native.register_toolchains("@com_github_edschouten_rules_elm//elm/toolchain:mac")
