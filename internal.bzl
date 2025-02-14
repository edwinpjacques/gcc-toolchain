# Copyright (c) Joby Aviation 2022
# Original authors: Thulio Ferraz Assis (thulio@aspect.dev), Aspect.dev
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Internal dependencies the users don't need."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

load("//examples/lapack:patches.bzl", "LAPACK_PATCHES")

# buildifier: disable=function-docstring
def internal_dependencies():
    maybe(
        http_archive,
        name = "io_bazel_stardoc",
        sha256 = "05fb57bb4ad68a360470420a3b6f5317e4f722839abc5b17ec4ef8ed465aaa47",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/stardoc/releases/download/0.5.2/stardoc-0.5.2.tar.gz",
            "https://github.com/bazelbuild/stardoc/releases/download/0.5.2/stardoc-0.5.2.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "aspect_bazel_lib",
        sha256 = "fc1ad541c749187714261fe94ef6157e2c0f0cb33e1ee4197436e9c8967d161c",
        strip_prefix = "bazel-lib-0.9.6",
        url = "https://github.com/aspect-build/bazel-lib/archive/refs/tags/v0.9.6.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_foreign_cc",
        sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
        strip_prefix = "rules_foreign_cc-0.9.0",
        url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.9.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "openssl",
        build_file_content = _ALL_SRCS,
        sha256 = "40dceb51a4f6a5275bde0e6bf20ef4b91bfc32ed57c0552e2e8e15463372b17a",
        strip_prefix = "openssl-1.1.1n",
        url = "https://www.openssl.org/source/openssl-1.1.1n.tar.gz",
    )

    maybe(
        http_archive,
        name = "lapack",
        build_file_content = _ALL_SRCS,
        patch_cmds = LAPACK_PATCHES,
        sha256 = "cd005cd021f144d7d5f7f33c943942db9f03a28d110d6a3b80d718a295f7f714",
        strip_prefix = "lapack-3.10.1",
        url = "https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.10.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "avl",
        build_file = "@//:examples/avl/avl.BUILD.bazel",
        sha256 = "6d62e563578b79795a84958cfe4e221a4c9847fbeb4a821d45bc049934fc6a90",
        strip_prefix = "Avl",
        url = "https://web.mit.edu/drela/Public/web/avl/avl3.40b.tgz",
    )

    maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = "85d42d4485f36f8cec3e475a3b9e841d7d78523cd775de3a86dba77081f4ca25",
        strip_prefix = "protobuf-3.21.4",
        urls = [
            "https://github.com/protocolbuffers/protobuf/archive/v3.21.4.tar.gz",
        ],
    )

_ALL_SRCS = """\
filegroup(
    name = "srcs",
    srcs = glob(
        include = ["**"],
        exclude = ["**/* *"],
    ),
    visibility = ["//visibility:public"],
)
"""
