class ZTT_CL_JUSTIFICATION definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  class-methods GET_JUSTIFICATION
    importing
      !IV_WRK_ID type SWW_WIID
    exporting
      !EV_REASON_TEXT type SO_TEXT255 .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_JUSTIFICATION IMPLEMENTATION.


  METHOD get_justification.

    DATA : lv_rcode TYPE sy-subrc,
           soli_tab TYPE soli_tab.




    CALL FUNCTION 'SAP_WAPI_DECISION_COMMENT'
      EXPORTING
        workitem_id       = iv_wrk_id
        language          = sy-langu
      IMPORTING
        return_code       = lv_rcode
        decision_soli_tab = soli_tab.

    .
    IF sy-subrc EQ 0 .
      ev_reason_text = soli_tab[ 1 ]-line.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
