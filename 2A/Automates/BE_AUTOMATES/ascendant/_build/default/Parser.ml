
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_VIRG
    | UL_VARIABLE of (
# 18 "Parser.mly"
       (string)
# 16 "Parser.ml"
  )
    | UL_SYMBOLE of (
# 17 "Parser.mly"
       (string)
# 21 "Parser.ml"
  )
    | UL_STP
    | UL_PT
    | UL_PAROUV
    | UL_PARFER
    | UL_NEG
    | UL_FIN
    | UL_FAIL
    | UL_DED
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 44 "Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_programme) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: programme. *)

  | MenhirState02 : (('s, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_state
    (** State 02.
        Stack shape : UL_SYMBOLE.
        Start symbol: programme. *)

  | MenhirState03 : (('s, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_state
    (** State 03.
        Stack shape : UL_VIRG.
        Start symbol: programme. *)

  | MenhirState06 : (('s, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_state
    (** State 06.
        Stack shape : UL_SYMBOLE.
        Start symbol: programme. *)

  | MenhirState14 : (('s, _menhir_box_programme) _menhir_cell1_programme_aux, _menhir_box_programme) _menhir_state
    (** State 14.
        Stack shape : programme_aux.
        Start symbol: programme. *)

  | MenhirState18 : (('s, _menhir_box_programme) _menhir_cell1_predicat, _menhir_box_programme) _menhir_state
    (** State 18.
        Stack shape : predicat.
        Start symbol: programme. *)

  | MenhirState20 : (('s, _menhir_box_programme) _menhir_cell1_UL_NEG, _menhir_box_programme) _menhir_state
    (** State 20.
        Stack shape : UL_NEG.
        Start symbol: programme. *)

  | MenhirState24 : ((('s, _menhir_box_programme) _menhir_cell1_predicat, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_state
    (** State 24.
        Stack shape : predicat deduction_aux.
        Start symbol: programme. *)

  | MenhirState25 : ((('s, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_state
    (** State 25.
        Stack shape : deduction_aux UL_VIRG.
        Start symbol: programme. *)

  | MenhirState26 : (((('s, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_state
    (** State 26.
        Stack shape : deduction_aux UL_VIRG deduction_aux.
        Start symbol: programme. *)


and ('s, 'r) _menhir_cell1_deduction_aux = 
  | MenhirCell1_deduction_aux of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_predicat = 
  | MenhirCell1_predicat of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_programme_aux = 
  | MenhirCell1_programme_aux of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_UL_NEG = 
  | MenhirCell1_UL_NEG of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_SYMBOLE = 
  | MenhirCell1_UL_SYMBOLE of 's * ('s, 'r) _menhir_state * (
# 17 "Parser.mly"
       (string)
# 114 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_VIRG = 
  | MenhirCell1_UL_VIRG of 's * ('s, 'r) _menhir_state

and _menhir_box_programme = 
  | MenhirBox_programme of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 52 "Parser.mly"
                  ( (print_endline "aux ; UL_VARIABLE ") )
# 128 "Parser.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 53 "Parser.mly"
               ( (print_endline "aux ; terme ") )
# 136 "Parser.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 54 "Parser.mly"
                     ( (print_endline "aux ; UL_VIRG ") )
# 144 "Parser.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 38 "Parser.mly"
                        ( (print_endline "axiome : predicat UL_PT ") )
# 152 "Parser.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 40 "Parser.mly"
                                                                ( (print_endline "deduction : predicat UL_DED deduction_aux UL_PT ") )
# 160 "Parser.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 45 "Parser.mly"
                         ( (print_endline "deduction_aux ; predicat ") )
# 168 "Parser.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 46 "Parser.mly"
                                  ( (print_endline "deduction_aux ; UL_NEG predicat ") )
# 176 "Parser.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 47 "Parser.mly"
                          ( (print_endline "deduction_aux ; FAIL ") )
# 184 "Parser.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 48 "Parser.mly"
                         ( (print_endline "deduction_aux ; UL_STP ") )
# 192 "Parser.ml"
     : (unit))

let _menhir_action_10 =
  fun () ->
    (
# 50 "Parser.mly"
                                              ( (print_endline "predicat ; UL_SYMBOLE UL_PAROUV suite_predicat UL_PARFER ") )
# 200 "Parser.ml"
     : (unit))

let _menhir_action_11 =
  fun () ->
    (
# 32 "Parser.mly"
                   ( (print_endline "programme : FIN ") )
# 208 "Parser.ml"
     : (unit))

let _menhir_action_12 =
  fun () ->
    (
# 33 "Parser.mly"
                               ( (print_endline "programme : programme_aux programme ") )
# 216 "Parser.ml"
     : (unit))

let _menhir_action_13 =
  fun () ->
    (
# 35 "Parser.mly"
                       ( (print_endline "programme : axiome ") )
# 224 "Parser.ml"
     : (unit))

let _menhir_action_14 =
  fun () ->
    (
# 36 "Parser.mly"
                 ( (print_endline "programme : deduction ") )
# 232 "Parser.ml"
     : (unit))

let _menhir_action_15 =
  fun () ->
    (
# 42 "Parser.mly"
                                         ( (print_endline "suite_deduction : /* Lambda, mot vide */") )
# 240 "Parser.ml"
     : (unit))

let _menhir_action_16 =
  fun () ->
    (
# 43 "Parser.mly"
                                                   ( (print_endline "suite_deduction : UL_VIRG deduction_aux suite_deduction") )
# 248 "Parser.ml"
     : (unit))

let _menhir_action_17 =
  fun () ->
    (
# 56 "Parser.mly"
                   ( (print_endline "terme ; UL_SYMBOLE ") )
# 256 "Parser.ml"
     : (unit))

let _menhir_action_18 =
  fun () ->
    (
# 57 "Parser.mly"
                                      ( (print_endline "terme ; UL_SYMBOLE UL_PAROUV aux UL_PARFER ") )
# 264 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | UL_DED ->
        "UL_DED"
    | UL_FAIL ->
        "UL_FAIL"
    | UL_FIN ->
        "UL_FIN"
    | UL_NEG ->
        "UL_NEG"
    | UL_PARFER ->
        "UL_PARFER"
    | UL_PAROUV ->
        "UL_PAROUV"
    | UL_PT ->
        "UL_PT"
    | UL_STP ->
        "UL_STP"
    | UL_SYMBOLE _ ->
        "UL_SYMBOLE"
    | UL_VARIABLE _ ->
        "UL_VARIABLE"
    | UL_VIRG ->
        "UL_VIRG"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_32_spec_00 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_programme =
    fun _menhir_stack _v ->
      MenhirBox_programme _v
  
  let rec _menhir_run_15 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_programme_aux -> _menhir_box_programme =
    fun _menhir_stack ->
      let MenhirCell1_programme_aux (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_12 () in
      _menhir_goto_programme _menhir_stack _v _menhir_s
  
  and _menhir_goto_programme : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_32_spec_00 _menhir_stack _v
      | MenhirState14 ->
          _menhir_run_15 _menhir_stack
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PAROUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_VIRG ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
          | UL_VARIABLE _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _ = _menhir_action_01 () in
              _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
          | UL_SYMBOLE _v_2 ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState02
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_03 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState03
      | UL_VARIABLE _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_01 () in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | UL_SYMBOLE _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_UL_VIRG -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_03 () in
      _menhir_goto_aux _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_goto_aux : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      match _menhir_s with
      | MenhirState02 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState03 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState06 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_11 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PARFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _) = _menhir_stack in
          let _v = _menhir_action_10 () in
          _menhir_goto_predicat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_predicat : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState25 ->
          _menhir_run_23_spec_25 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState18 ->
          _menhir_run_23_spec_18 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState20 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState00 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState14 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_23_spec_25 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_cell1_UL_VIRG -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_06 () in
      _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState25 _tok
  
  and _menhir_run_26 : type  ttv_stack. (((ttv_stack, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_cell1_UL_VIRG as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_deduction_aux (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState26
      | UL_PT ->
          let _ = _menhir_action_15 () in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_deduction_aux as 'stack) -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState25
      | UL_STP ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_09 () in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState25 _tok
      | UL_NEG ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
      | UL_FAIL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_08 () in
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState25 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_20 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_NEG (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. (((ttv_stack, _menhir_box_programme) _menhir_cell1_deduction_aux, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_cell1_deduction_aux -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_deduction_aux (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_16 () in
      _menhir_goto_suite_deduction _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_suite_deduction : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_deduction_aux as 'stack) -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState24 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState26 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_28 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_predicat, _menhir_box_programme) _menhir_cell1_deduction_aux -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_deduction_aux (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_predicat (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_05 () in
      let _v = _menhir_action_14 () in
      _menhir_goto_programme_aux _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_programme_aux : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_programme_aux (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v_0 ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState14
      | UL_FIN ->
          let _ = _menhir_action_11 () in
          _menhir_run_15 _menhir_stack
      | _ ->
          _eRR ()
  
  and _menhir_run_23_spec_18 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_predicat -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_06 () in
      _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18 _tok
  
  and _menhir_run_24 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_predicat as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_deduction_aux (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState24
      | UL_PT ->
          let _ = _menhir_action_15 () in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_21 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_UL_NEG -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_UL_NEG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_07 () in
      _menhir_goto_deduction_aux _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_deduction_aux : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState25 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState18 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_16 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _ = _menhir_action_04 () in
          let _v = _menhir_action_13 () in
          _menhir_goto_programme_aux _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | UL_DED ->
          let _menhir_stack = MenhirCell1_predicat (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_SYMBOLE _v_0 ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState18
          | UL_STP ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_09 () in
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18 _tok
          | UL_NEG ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
          | UL_FAIL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_08 () in
              _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      match (_tok : MenhirBasics.token) with
      | UL_PARFER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _) = _menhir_stack in
          let _ = _menhir_action_18 () in
          _menhir_goto_terme _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_terme : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok ->
      let _ = _menhir_action_02 () in
      _menhir_goto_aux _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PAROUV ->
          let _menhir_stack = MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_VIRG ->
              _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
          | UL_VARIABLE _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _ = _menhir_action_01 () in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
          | UL_SYMBOLE _v_2 ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState06
          | _ ->
              _eRR ())
      | UL_PARFER ->
          let _ = _menhir_action_17 () in
          _menhir_goto_terme _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s _tok
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | UL_FIN ->
          let _v = _menhir_action_11 () in
          _menhir_run_32_spec_00 _menhir_stack _v
      | _ ->
          _eRR ()
  
end

let programme =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_programme v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 59 "Parser.mly"
  

# 614 "Parser.ml"
