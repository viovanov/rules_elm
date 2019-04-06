load("//elm:def.bzl", _ElmLibrary = "ElmLibrary")

def _convert_proto_to_elm_path(path):
    return "/".join([component.capitalize() for component in path.split("/")])

def _elm_proto_library_impl(ctx):
    args = ctx.actions.args()
    proto = ctx.attr.proto.proto
    elm_srcs = []
    outpath = None
    for src in proto.direct_sources:
        # Add command line flag for input file.
        base_path = src.path[len(src.owner.workspace_root) + 1:]
        args.add_all([base_path])

        # Declare output file. Elm uses capitalized package names.
        output_path = "/".join([
            component.capitalize()
            for component in base_path.split("/")
        ])[:-6] + ".elm"
        out = ctx.actions.declare_file(output_path)
        elm_srcs.append(out)

        # Determine the base output directory for --elm_out.
        if outpath == None:
            outpath = out.root.path + "/" + ctx.label.workspace_root + "/" + ctx.label.package

    args.add_all([
        "--plugin",
        ctx.executable._plugin.path,
        "--elm_out",
        outpath,
    ])
    args.add_all(proto.transitive_proto_path, before_each = "-I")

    # TODO(edsch): This should be removed once this is resolved:
    # https://github.com/bazelbuild/bazel/issues/7964
    args.add_all([
        "bazel-out/k8-fastbuild/genfiles/" + p
        for p in proto.transitive_proto_path.to_list()
    ], before_each = "-I")
    ctx.actions.run(
        executable = ctx.executable._protoc,
        arguments = [args],
        inputs = proto.transitive_sources + [ctx.executable._plugin],
        outputs = elm_srcs,
    )

    # TODO(edsch): Fill in transitive source_directories.
    return [
        _ElmLibrary(
            dependencies = depset(),
            package_directories = depset(),
            source_directories = depset([outpath]),
            source_files = depset(elm_srcs),
        ),
    ]

elm_proto_library = rule(
    _elm_proto_library_impl,
    attrs = {
        "proto": attr.label(
            mandatory = True,
            providers = ["proto"],
        ),
        "_protoc": attr.label(
            allow_files = True,
            single_file = True,
            executable = True,
            cfg = "host",
            default = Label("@com_google_protobuf//:protoc"),
        ),
        "_plugin": attr.label(
            allow_files = True,
            single_file = True,
            executable = True,
            cfg = "host",
            default = Label("@com_github_tiziano88_elm_protobuf//protoc-gen-elm"),
        ),
    },
)
