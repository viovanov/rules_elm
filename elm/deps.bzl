load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")

def elm_register_toolchains():
    _http_archive(
        name = "com_github_elm_compiler_linux",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "a627e3947a51ca2474ca8c5642090b9264032f89f109b2c8f3f6b63f0782f944",
        urls = ["https://github.com/viovanov/rules_elm/releases/download/elm-0.19.1-files/binary-for-linux-64-bit.zip"],
    )

    _http_archive(
        name = "com_github_elm_compiler_mac",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "e1323988d1ac02aa708c9acc8ff1f92a246cea5c6b472aa8475642c050bb2928",
        urls = ["https://github.com/viovanov/rules_elm/releases/download/elm-0.19.1-files/binary-for-mac-64-bit.zip"],
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
