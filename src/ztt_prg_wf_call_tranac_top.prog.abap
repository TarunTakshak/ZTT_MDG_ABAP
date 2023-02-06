*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_WF_CALL_TRANAC_TOP
*&---------------------------------------------------------------------*

DATA :
"local variable for sy-subrc check
       lv_rcode TYPE sysubrc,
"local variable to workitem id
       lv_wid   TYPE sww_wiid,
"internal table for container
       lt_cont  TYPE TABLE OF swr_cont,
"local variable for sales document
       ls_vbeln TYPE vbak.

PARAMETERS :
"parameter to hold sales document
            pv_vbeln TYPE vbak-vbeln.
