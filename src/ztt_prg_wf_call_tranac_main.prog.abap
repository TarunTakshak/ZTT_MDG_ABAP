*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_WF_CALL_TRANAC_MAIN
*&---------------------------------------------------------------------*


*SELECT SINGLE * FROM vbak INTO ls_vbeln WHERE vbeln = pv_vbeln.

*IF sy-subrc = 0 .

  lt_cont = VALUE swrtcont(
                               ( element = 'vbeln' value = pv_vbeln )
                               ( element = 'username' value = 'USTAKSHAKT'  )

                          ).
  CALL FUNCTION 'SAP_WAPI_START_WORKFLOW'
    EXPORTING
      task            = 'WS90100186'
      do_commit       = abap_true
    IMPORTING
      return_code     = lv_rcode
      workitem_id     = lv_wid
    TABLES
      input_container = lt_cont.


  IF lv_rcode IS  INITIAL.

    WRITE : lv_wid.

  ENDIF.
*
*ELSE.
*
*  MESSAGE 'SALES DOCUMENT NUMBER NOT FOUND ' TYPE 'E'.
*
*ENDIF
