*&---------------------------------------------------------------------*
*& Report ZTT_PRG_WF_MULTILINE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_wf_multiline.
INCLUDE <cntn01>.

DATA : lt_cust   TYPE TABLE OF kna1,
       lv_task    TYPE  swwwihead-wi_rh_task VALUE 'WS90100197',
       lt_cont   TYPE TABLE OF swcont,
       lv_wid    TYPE swwwihead-wi_id,
       lv_entries TYPE i VALUE 5.

SELECT * FROM kna1 INTO TABLE lt_cust UP TO 5 ROWS.

IF sy-subrc = 0.

  swc_set_table lt_cont 'CUST'  lt_cust.
  swc_set_element lt_cont 'ENTRIES' lv_entries.

  CALL FUNCTION 'EWW_WORKFLOW_START'
    EXPORTING
      x_task        = lv_task

    IMPORTING
      y_workflow_id = lv_wid

     TABLES
      x_container   = lt_cont
.
  IF sy-subrc = 0.

  ENDIF.

    WRITE : lv_wid.

ENDIF.
