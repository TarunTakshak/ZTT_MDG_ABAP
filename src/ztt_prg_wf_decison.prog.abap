*&---------------------------------------------------------------------*
*& Report ZTT_PRG_WF_DECISON
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_wf_decison.


DATA : lv_rcode TYPE sysubrc,
       lv_wid   TYPE sww_wiid,
       lt_cont  TYPE TABLE OF swr_cont,
       lt_dep   TYPE swrtwihdr.

"swrtcont is table type for swr_cont.
"swrtwihdr is table type of SWR_WIHDR->which is structure

lt_cont = VALUE swrtcont(
                         " ( element = 'EMP_NAME' value = '01011500')
                          ( element = 'Emp_id' value = '01011500')
                          ( element = 'LEAVE_TYPE' value = 'sick')
                          ( element = 'MANAGER' value = 'USTAKSHAKT' )
                      "    ( element = 'MANAGER_2' value = 'USINGALEA' )
                       "   ( element = 'MANAGER_3' value = 'USSANDEEPS' )
                          ( element = 'DATE' value = sy-datum )
                          ( element = 'Email' value = 'tarun@yash.com' )
                         ).

CALL FUNCTION 'SAP_WAPI_START_WORKFLOW'
  EXPORTING
    task            = 'WS90100143'
    do_commit       = 'X'
  IMPORTING
    return_code     = lv_rcode
    workitem_id     = lv_wid
  TABLES
    input_container = lt_cont
*   MESSAGE_LINES   =
  .
IF lv_rcode IS INITIAL.

  WRITE: lv_wid.

ENDIF.
*
*CALL FUNCTION 'SAP_WAPI_GET_DEPENDENT_WIS'
*  EXPORTING
*    workitem_id = lv_wid
**   DIRECT_DEPENDANTS_ONLY       = ' '
**   USER        = SY-UNAME
**   LANGUAGE    = SY-LANGU
**   TRANSLATE_WI_TEXT            = ' '
**   STATUS      =
*  IMPORTING
*    return_code = lv_rcode
*  TABLES
*    items       = lt_dep
**   MESSAGE_LINES                =
**   MESSAGE_STRUCT               =
*  .
*
*IF lv_rcode IS INITIAL.
*
*  IF line_exists( lt_dep[ wi_type = 'W' ] ).
*    CALL FUNCTION 'SAP_WAPI_DECISION_COMPLETE'
*      EXPORTING
*        workitem_id  = lv_wid
*        decision_key = '0001'
*      IMPORTING
*        return_code  = lv_rcode
*                       .
*    endif.
*
*  ENDIF.
