"""Shared utils"""

def files_relative_to_package(ctx, files):
    """Package-relative paths for a list of files, computing the prefixes only once."""
    bin_dir_prefix = ctx.bin_dir.path + "/"
    workspace_prefix = ctx.label.workspace_name + "/"
    package_prefix = ctx.label.package + "/" if ctx.label.package else None

    paths = []
    for file in files:
        path = file.path.removeprefix(bin_dir_prefix)
        path = path.removeprefix("external/")
        path = path.removeprefix(workspace_prefix)
        if package_prefix:
            path = path.removeprefix(package_prefix)
        paths.append(path)
    return paths

def to_out_path(f, out_dir, root_dir):
    f = f[f.find(":") + 1:]

    if out_dir and f.startswith(out_dir + "/"):
        return f

    if root_dir:
        f = f.removeprefix(root_dir + "/")
    if out_dir:
        f = out_dir + "/" + f
    return f

