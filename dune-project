(lang dune 3.8)

(name data_structures_in_ocaml)

(generate_opam_files true)

(source
 (github trite/data_structures_in_ocaml))

(authors "Paul Brunner")

(maintainers "Paul Brunner")

(license MIT)

(documentation https://github.com/trite/data_structures_in_ocaml)

(package
 (name data_structures_in_ocaml)
 (synopsis "Data structures in OCaml")
 (description
  "Implementing various data structures in OCaml because I need more practice.")
 (depends ocaml dune)
 (tags
  (data-structures ocaml)))
