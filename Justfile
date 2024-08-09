# https://gist.github.com/trite/77f77cb39fb0a79f467e9809703fe516
# Relatively basic Justfile for an OCaml 5.2.0 project
#
# Notes:
# * Run `just` for list of all available recipes
# * Run `just hard-reset init` to delete generated files and re-initialize the project
# * Update dune-project to add deps, install with `just install`

@_default:
  just --list

# Name of the project, necessary for generating the .opam file
project_name := "data_structures_in_ocaml"

# Folder in which the build artifacts are stored
build_path := "_build/default/"

# Path to the executable (relative to the build path / project root)
exe_path := "bin/main.exe"

# Path to opam binary
opam := "opam"

dune := opam + " exec -- dune"

# Remove all generated files
hard-reset:
  rm -f {{ project_name }}.opam
  rm -rf _build
  rm -rf _opam

# Create Opam switch
create-switch:
  {{ opam }} switch create . 5.2.0 -y --deps-only

# Install dependencies (update via dune-project, opam file is generated from it)
install:
  {{ dune }} build {{ project_name }}.opam # Generate/re-generate .opam file from dune-project
  {{ opam }} install -y . --deps-only --with-test

# Full install, the `&& install` means run the install recipe after this recipe
full-install: && install
  {{ opam }} update
  {{ opam }} install dune

# Initialize the project
# Runs `create-switch`, then `full-install`, and lastly `install` recipes
init: create-switch full-install

# Watch for changes and rebuild
watch:
  {{ dune }} build -w

# Build
build:
  {{ dune }} build

# Execute file, passing along any arguments
run *args:
  {{ build_path }}{{ exe_path }} {{ args }}

# Execute file in debug mode, passing along any args.
# Requires the `-g` flag to be set in the appropriate dune file
#   (https://dune.readthedocs.io/en/latest/concepts/ocaml-flags.html).
# If you prefer to execute via dune (I don't since watch can't run at the same time):
#   OCAMLRUNPARAM=b {{ dune }} exec {{ exe_path }} {{ args }}
debug *args:
  OCAMLRUNPARAM=b {{ build_path }}{{ exe_path }} {{ args }}

# Run ocamlformat on the project
format:
  {{ dune }} build @fmt --auto-promote