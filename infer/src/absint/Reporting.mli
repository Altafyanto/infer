(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd

(** Type of functions to report issues to the error_log in a spec. *)

type log_t = ?ltr:Errlog.loc_trace -> ?extras:Jsonbug_t.extra -> IssueType.t -> string -> unit

val log_issue_from_summary :
     Exceptions.severity
  -> ProcAttributes.t
  -> Errlog.t
  -> node:Errlog.node
  -> session:int
  -> loc:Location.t
  -> ltr:Errlog.loc_trace
  -> ?extras:Jsonbug_t.extra
  -> exn
  -> unit

val log_frontend_issue :
     Exceptions.severity
  -> Errlog.t
  -> loc:Location.t
  -> node_key:Procdesc.NodeKey.t
  -> ltr:Errlog.loc_trace
  -> exn
  -> unit
(** Report a frontend issue of a given kind in the given error log. *)

val log_error : ProcAttributes.t -> Errlog.t -> loc:Location.t -> log_t
(** Add an error to the given error log. *)

val log_warning : ProcAttributes.t -> Errlog.t -> loc:Location.t -> log_t
(** Add a warning to the given error log. *)

val log_issue_external :
     Procname.t
  -> issue_log:IssueLog.t
  -> Exceptions.severity
  -> loc:Location.t
  -> ltr:Errlog.loc_trace
  -> ?access:string
  -> ?extras:Jsonbug_t.extra
  -> IssueType.t
  -> string
  -> IssueLog.t
(** Log an issue to the error log in [IssueLog] associated with the given procname. *)

val is_suppressed : ?field_name:Fieldname.t option -> Tenv.t -> Procdesc.t -> IssueType.t -> bool
(** should an issue report be suppressed due to a [@SuppressLint("issue")] annotation? *)
