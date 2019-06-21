(* Copyright (c) 2019-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree. *)

module Path = PyrePath

type t =
  | Root of Path.t
  | Subdirectory of { root: Path.t; subdirectory: string }
[@@deriving sexp, compare, hash, show, eq]

val get_root : t -> Path.t

val to_path : t -> Path.t

val create : string -> t

val search_for_path : search_path:t list -> path:Path.t -> Path.t option
