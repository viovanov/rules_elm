load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")

def elm_register_toolchains():
    _http_archive(
        name = "com_github_elm_compiler_linux",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "f66f42582821a0d6a5d3305d9c4df1d47ae9066ae4b367deb8901117d68f05f0",
        urls = ["https://github.com/viovanov/rules_elm/releases/download/elm-0.19.1-files/binary-for-linux-64-bit.zip"],
    )

    _http_archive(
        name = "com_github_elm_compiler_mac",
        build_file_content = """exports_files(["elm"])""",
        sha256 = "4a112c8fc2478a7f05759d3e1474d3493b4666733cb46ea34c3690e8dbf9e6c9",
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
