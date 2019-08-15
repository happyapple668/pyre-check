(* Copyright (c) 2016-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree. *)

type parse_result =
  | Success of Ast.Source.t
  | SyntaxError of string
  | SystemError of string

val parse_source : configuration:Configuration.Analysis.t -> Ast.SourcePath.t -> parse_result

type parse_sources_result = {
  parsed: Ast.Source.t list;
  syntax_error: Ast.SourcePath.t list;
  system_error: Ast.SourcePath.t list;
}

val parse_sources
  :  configuration:Configuration.Analysis.t ->
  scheduler:Scheduler.t ->
  preprocessing_state:ProjectSpecificPreprocessing.state option ->
  ast_environment:Analysis.AstEnvironment.t ->
  Ast.SourcePath.t list ->
  parse_sources_result

val parse_all
  :  scheduler:Scheduler.t ->
  configuration:Configuration.Analysis.t ->
  Analysis.ModuleTracker.t ->
  Ast.Source.t list * Analysis.AstEnvironment.t

(* Update the AstEnvironment and return the list of module names whose parsing result may have
   changed *)
val update
  :  configuration:Configuration.Analysis.t ->
  scheduler:Scheduler.t ->
  ast_environment:Analysis.AstEnvironment.t ->
  Analysis.ModuleTracker.IncrementalUpdate.t list ->
  Ast.Reference.t list
