*&---------------------------------------------------------------------*
*& Report ZTT_WF_USER_DECSION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_wf_user_decsion.

DATA : lv_rcode    TYPE sysubrc,
       lv_wid      TYPE sww_wiid,
       lt_cont     TYPE TABLE OF swr_cont,
       lt_messages TYPE sapi_msg_lines,
       lt_dep_wis  TYPE swrtwihdr.

lt_cont = VALUE swrtcont(

                   ( element = 'IvEmpid'   value = '01011501' )
                   ( element = 'LEAVE_TYPE' value = 'SL' )
                   ( element = 'MANAGER'    value = 'USGENERIC-01' ) " AG<ROleID> "P1011496 "S1011JC29
                   ( element = 'Email_Address'    value = 'chandra@gmail.com' )
                   ( element = 'VALUE'    value = '15' )
                ).
CALL FUNCTION 'SAP_WAPI_START_WORKFLOW'
  EXPORTING
    task            = 'WS90100106'
    do_commit       = abap_true
    user            = sy-uname
  IMPORTING
    return_code     = lv_rcode
    workitem_id     = lv_wid
  TABLES
    input_container = lt_cont
    message_lines   = lt_messages.

IF lv_rcode IS INITIAL.
  WRITE lv_wid.
ENDIF.

*CALL FUNCTION 'SAP_WAPI_GET_DEPENDENT_WIS'
*  EXPORTING
*    workitem_id            = lv_wid
*    direct_dependants_only = abap_true
*  IMPORTING
*    return_code            = lv_rcode
*  TABLES
*    items                  = lt_dep_wis.

*IF lv_rcode IS INITIAL.
*
*  IF line_exists( lt_dep_wis[ wi_type = 'W' ] ).
*    CALL FUNCTION 'SAP_WAPI_DECISION_COMPLETE'
*      EXPORTING
*        workitem_id  = lt_dep_wis[ 1 ]-wi_id
*        decision_key = '0001'
*      IMPORTING
*        return_code  = lv_rcode.
*
*
*  ENDIF.

*ENDIF.
