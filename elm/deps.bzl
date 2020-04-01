load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")

def elm_register_toolchains():
    _http_archive(
        name = "com_github_elm_compiler_linux",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "e44af52bb27f725a973478e589d990a6428e115fe1bb14f03833134d6c0f155c",
        urls = ["https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz"],
    )

    _http_archive(
        name = "com_github_elm_compiler_mac",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "05289f0e3d4f30033487c05e689964c3bb17c0c48012510dbef1df43868545d1",
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
