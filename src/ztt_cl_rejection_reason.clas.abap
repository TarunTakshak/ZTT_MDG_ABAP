class ZTT_CL_REJECTION_REASON definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  class-methods READ_ATTACH
    importing
      !IV_WRK_ID type SWR_STRUCT-WORKITEMID
    exporting
      !EV_REASON_TEXT type SO_TEXT255 .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_REJECTION_REASON IMPLEMENTATION.


  method READ_ATTACH.

   data : lv_rcode type sy-subrc,
           soli_tab TYPE soli_tab.

   CALL FUNCTION 'SAP_WAPI_DECISION_COMPLETE'
     EXPORTING
       workitem_id                     = iv_wrk_id
       language                        = sy-langu

    IMPORTING
      RETURN_CODE                     = lv_rcode
             .
  IF sy-subrc eq 0 .
    ev_reason_text = soli_tab[ 1 ]-line.

  ENDIF.



  endmethod.
ENDCLASS.
