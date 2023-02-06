*&---------------------------------------------------------------------*
*& Report ZTT_PRG_BRF_RULESET
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_brf_ruleset.





DATA: lo_factory          TYPE REF TO if_fdt_factory,
      lo_rule             TYPE REF TO if_fdt_rule,
      lo_function         TYPE REF TO if_fdt_function,
      lo_result           TYPE REF TO if_fdt_result,
      lo_context          TYPE REF TO if_fdt_context,
      lo_admin_data       TYPE REF TO if_fdt_admin_data,
      lo_actn_msg_log     TYPE REF TO if_fdt_actn_message_log,
      lr_data             TYPE REF TO data,
      lo_data_object      TYPE REF TO if_fdt_data_object,
      lt_messages         TYPE if_fdt_types=>t_message,
      ls_messages         TYPE if_fdt_types=>s_message,
      lv_condition_id     TYPE if_fdt_types=>id,
      lts_context_id      TYPE if_fdt_types=>ts_object_id,
      lv_actv_failed      TYPE abap_bool,
      lt_actn_msg_log_par TYPE if_fdt_actn_message_log=>ts_message,
      ls_actn_msg_log_par TYPE if_fdt_actn_message_log=>s_message,
      logobj              TYPE balobj_d  VALUE 'FDT',
      logsub              TYPE balsubobj VALUE 'FDT_MSG_ACTION',
      lv_id               TYPE if_fdt_types=>id.

FIELD-SYMBOLS:
     <lt_rslt_table>     TYPE table,
     <lt_rslt_struct>    TYPE any.

PARAMETERS: pv_actn TYPE abap_bool DEFAULT abap_true.



START-OF-SELECTION.
" Get an instance of the FDT factory.
  lo_factory = cl_fdt_factory=>if_fdt_factory~get_instance( '73C2E987EB041EEDA79355E145E89595').

  cl_fdt_convenience=>create_element( EXPORTING iv_name           = 'CONDITION'
                                                    iv_application_id =  '73C2E987EB041EEDA79355E145E89595'
                                                    iv_element_type   = if_fdt_constants=>gc_element_type_boolean
                                                    iv_activate       = abap_false
                                          IMPORTING ev_element_id     = lv_condition_id ).
  INSERT lv_condition_id INTO TABLE lts_context_id.

" Create a rule expression and set some attributes to it.
  lo_rule ?= lo_factory->get_expression( iv_expression_type_id = if_fdt_constants=>gc_exty_rule ).
  lo_rule->if_fdt_transaction~enqueue( ).
  lo_rule->if_fdt_admin_data~set_name( 'rule-name' ).

" Rule Condition has to be a boolean value
  lo_rule->set_condition( lv_condition_id ).

 "Create an action message to set as the false action and set some attributes.
  lo_actn_msg_log ?= lo_factory->get_expression( iv_expression_type_id = if_fdt_actn_message_log=>gc_exty_message_log ).
  lo_actn_msg_log->if_fdt_transaction~enqueue( ).
  lo_actn_msg_log->if_fdt_admin_data~set_name( 'sample01' ).
  lo_actn_msg_log->set_application_log_object( EXPORTING iv_log_object    = logobj
                                                         iv_log_subobject = logsub ).

  lo_actn_msg_log->set_persistency_settings( abap_false ).
  ls_actn_msg_log_par-msgid = 'FDT_DEMO_OBJECTS'.
  ls_actn_msg_log_par-msgno = '002'.
  ls_actn_msg_log_par-msgty = 'I'.
  INSERT ls_actn_msg_log_par INTO TABLE lt_actn_msg_log_par.
  lo_actn_msg_log->set_messages( lt_actn_msg_log_par ).

" Set the false action of the rule
  lo_rule->set_false_action( lo_actn_msg_log->if_fdt_admin_data~mv_id ).

"Create an action message to set as the True action and set some attributes.
  CLEAR: ls_actn_msg_log_par, lt_actn_msg_log_par.
  lo_actn_msg_log ?= lo_factory->get_expression( iv_expression_type_id = if_fdt_actn_message_log=>gc_exty_message_log ).
  lo_actn_msg_log->if_fdt_transaction~enqueue( ).
  lo_actn_msg_log->if_fdt_admin_data~set_name( 'sample02' ).
  lo_actn_msg_log->set_application_log_object( EXPORTING iv_log_object    = logobj
                                                         iv_log_subobject = logsub ).

  lo_actn_msg_log->set_persistency_settings( abap_false ).
  ls_actn_msg_log_par-msgid = 'FDT_DEMO_OBJECTS'.
  ls_actn_msg_log_par-msgno = '001'.
  ls_actn_msg_log_par-msgty = 'I'.
  INSERT ls_actn_msg_log_par INTO TABLE lt_actn_msg_log_par.
  lo_actn_msg_log->set_messages( lt_actn_msg_log_par ).
" Set the True action of the rule
  lo_rule->set_true_action( lo_actn_msg_log->if_fdt_admin_data~mv_id ).

 "Create a function instance using factory.
  lo_function ?= lo_factory->get_function( ).
 "Setting some attributes of the function
  lo_function->if_fdt_transaction~enqueue( ).
  lo_function->if_fdt_admin_data~set_name( cl_fdt_services=>get_unique_name( ) ).
  lo_function->set_context_data_objects( lts_context_id ).
  lo_function->set_result_data_object( if_fdt_action=>gc_dobj_action_table ).
  lo_function->set_expression( lo_rule->if_fdt_admin_data~mv_id ).

 "Perform deep activation & saving.
  DATA : lt_message TYPE if_fdt_types=>t_message,
         lv_message TYPE string,
         lx_fdt     TYPE REF TO cx_fdt.

  FIELD-SYMBOLS:
         <ls_message>  TYPE if_fdt_types=>s_message.


  lo_function->if_fdt_transaction~activate(
    EXPORTING iv_deep              = abap_true
    IMPORTING et_message           = lt_message
              ev_activation_failed = lv_actv_failed ).


  IF lv_actv_failed EQ abap_true.
    lo_function->if_fdt_transaction~dequeue(
      EXPORTING iv_deep              = abap_true ).
    WRITE : / 'Deep activation failed'.                     "#EC NOTEXT
    LOOP AT lt_message ASSIGNING <ls_message>.
      MESSAGE ID <ls_message>-msgid TYPE <ls_message>-msgty NUMBER <ls_message>-msgno
          WITH <ls_message>-msgv1 <ls_message>-msgv2 <ls_message>-msgv3 <ls_message>-msgv4
          INTO lv_message.
      WRITE: / 'Reason : -',lv_message.                     "#EC NOTEXT
    ENDLOOP.
  ELSE.
    TRY.
        lo_function->if_fdt_transaction~save(
          EXPORTING iv_deep              = abap_true ).
      CATCH cx_fdt INTO lx_fdt.
        WRITE : / 'Save failed with exception'.             "#EC NOTEXT
        LOOP AT lx_fdt->mt_message ASSIGNING <ls_message>.
          WRITE :/ <ls_message>-text.
        ENDLOOP.
    ENDTRY.

    lo_function->if_fdt_transaction~dequeue(
      EXPORTING iv_deep              = abap_true ).
  ENDIF.

"====================================================================================
" run-time
 "Process the function on successful activation and display result .
 "Catch exception if any.
  IF lv_actv_failed NE abap_true.
 "Using the context of the function.
    lo_context = lo_function->get_process_context( ).
    lo_context->set_value( iv_id = lv_condition_id ia_value = pv_actn ).

    TRY.
        lo_function->process( EXPORTING io_context = lo_context
                                IMPORTING eo_result  = lo_result ).
      CATCH cx_fdt INTO lx_fdt.
        LOOP AT lx_fdt->mt_message ASSIGNING <ls_message>.
          WRITE :/ <ls_message>-text.
        ENDLOOP.
    ENDTRY.
  ENDIF.

  IF lo_result IS BOUND.
    lo_data_object = lo_result->get_data_object( ).
    lo_data_object->create_data_reference( IMPORTING er_data = lr_data ).
    ASSIGN lr_data->* TO <lt_rslt_table>.
    lo_result->get_value( IMPORTING ea_value = <lt_rslt_table> ).
    LOOP AT <lt_rslt_table> ASSIGNING <lt_rslt_struct>.
      lv_id = <lt_rslt_struct>.
      cl_fdt_factory=>get_instance_generic( EXPORTING iv_id = lv_id
        IMPORTING eo_instance = lo_admin_data ).
      lo_actn_msg_log ?= lo_admin_data.
      lt_actn_msg_log_par = lo_actn_msg_log->get_messages( ).
      LOOP AT lt_actn_msg_log_par INTO ls_actn_msg_log_par.
        MESSAGE ID ls_actn_msg_log_par-msgid TYPE ls_actn_msg_log_par-msgty NUMBER ls_actn_msg_log_par-msgno.
      ENDLOOP.
    ENDLOOP.
  ENDIF.
**

**********************************************************************
**********************************************************************

*DATA: lo_ruleset     TYPE REF TO if_fdt_ruleset,
*      lts_rule       TYPE if_fdt_ruleset=>ts_rule,
*      lts_variable   TYPE if_fdt_ruleset=>ts_variable,
*      lo_factory     TYPE  REF TO if_fdt_factory,
*      lts_expression TYPE if_fdt_ruleset=>ts_init_expr.
*
*PARAMETERS : p_cond1 TYPE tabname.
*
*
*lo_factory = cl_fdt_factory=>if_fdt_factory~get_instance(
* iv_application_id = '73C2E987EB041EEDA79355E145E89595' ).
*lo_ruleset ?= lo_factory->get_ruleset( ).
*lo_ruleset->if_fdt_transaction~enqueue( ).
*lo_ruleset->set_ruleset_switch( iv_switch = if_fdt_ruleset=>gc_switch_on ).
*lo_ruleset->if_fdt_admin_data~set_name( p_cond1 ).
*lo_ruleset->if_fdt_admin_data~set_texts( iv_short_text = 'sample rules' iv_text = 'sample rules1' ).
*lo_ruleset->set_function_restriction( iv_function_id = '73C2E987EB041EEDA7935EA495FFD5A4').
*
*lo_ruleset->set_ruleset_variables( lts_variable ).
*
*
*lo_ruleset->set_ruleset_initializations( lts_expression ).
*lo_ruleset->set_rules( lts_rule ).
*lo_ruleset->if_fdt_transaction~activate(
* EXPORTING iv_deep = abap_true
* IMPORTING et_message = DATA(lt_message)
* ev_activation_failed = DATA(lv_boolean) ).
*
*lo_ruleset->if_fdt_transaction~save(
* EXPORTING iv_deep = abap_true ).
*
*
*lo_ruleset->if_fdt_transaction~dequeue(
* EXPORTING iv_deep = abap_true ).
*
*IF sy-subrc EQ 0 .
*  MESSAGE 'ok set' TYPE 'I'.
*ENDIF.

*********************************************************************
*********************************************************************
*DATA: lo_rule             TYPE REF TO if_fdt_rule,
*
*      ls_rule             TYPE if_fdt_ruleset=>s_rule,
*      ls_cond_range       TYPE if_fdt_range=>s_param_range,
*      ls_rule_expr        TYPE if_fdt_rule=>s_expression,
*      lt_rule_expr        TYPE if_fdt_rule=>t_expression,
*      lv_formula_cus_disc TYPE if_fdt_types=>id,
*      lv_formula_pro_disc TYPE if_fdt_types=>id,
*      lv_pro_discount     TYPE if_fdt_types=>id,
*      lv_cus_discount     TYPE if_fdt_types=>id,
*      ls_range            TYPE if_fdt_range=>s_range.
*
*
*
*lo_rule ?= lo_factory->get_expression(
* iv_expression_type_id = if_fdt_constants=>gc_exty_rule ).
*lo_rule->if_fdt_transaction~enqueue( ).
*lo_rule->if_fdt_admin_data~set_name( iv_name = 'Rule'  ).
*lo_rule->if_fdt_admin_data~set_texts( iv_text = 'sample' ).
*CLEAR ls_cond_range.
*
*ls_cond_range-parameter_id = lv_pro_discount.
*ls_range-position = 1.
*ls_range-sign = if_fdt_range=>gc_sign_include.
*ls_range-option = if_fdt_range=>gc_option_greater.
*ls_range-low = lv_cus_discount.
*INSERT ls_range INTO TABLE ls_cond_range-ts_range.
*
*
*lo_rule->set_condition_range( ls_cond_range ).
*
*
*ls_rule_expr-position = 1.
*ls_rule_expr-change_mode = if_fdt_rule=>gc_change_mode_update.
*ls_rule_expr-expression = '73C2E987EB041EEDA793C871BDBE15E2'.
*INSERT ls_rule_expr INTO TABLE lt_rule_expr.
*
*
*lo_rule->set_true_action_extended(
* it_expression = lt_rule_expr ).
*CLEAR lt_rule_expr.
*
*ls_rule_expr-expression = lv_formula_cus_disc.
*INSERT ls_rule_expr INTO TABLE lt_rule_expr.
*
*
*lo_rule->set_false_action_extended( it_expression = lt_rule_expr ).
*ls_rule-position = 1.
*ls_rule-rule_id = '73C2E987EB041EEDA89094B6A6F09D1D'.
*ls_rule-switch = if_fdt_ruleset=>gc_switch_on.
*INSERT ls_rule INTO TABLE lts_rule.
*
*IF sy-subrc EQ 0 .
*  MESSAGE 'ok' TYPE 'I'.
*ENDIF.
