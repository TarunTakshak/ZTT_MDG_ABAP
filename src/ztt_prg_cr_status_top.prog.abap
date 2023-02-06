*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_CR_STATUS_TOP
*&---------------------------------------------------------------------*

TABLES : usmd120c.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 2(20) TEXT-003.
    PARAMETERS : p_userna TYPE sy-uname OBLIGATORY.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 2(20) TEXT-002.
    PARAMETERS : p_crtype TYPE usmd120c-usmd_creq_type OBLIGATORY.
  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b1.

TYPES:
*structure to hold cr status and agent
  BEGIN OF ty_final,
    usmd_crequest    TYPE  usmd_crequest,        "change request
    usmd_creq_type   TYPE  usmd_crequest_type,   "change request type
    usmd_created_by  TYPE  xubname,              "created by
    usmd_creq_status TYPE usmd_crequest_status,  "change request status
    txtmi            TYPE  usmd_txtmi,           "description
    wi_agnt          TYPE ad_namtext,               "agent
  END OF ty_final.

DATA :"internal table for TOP workitem
  lt_t_wid       TYPE swr_wihdr_table,
  "internal table for sub workitem
  lt_swid        TYPE tswwwihead,
  "internal table for workitem id
  lt_wfid        TYPE usmd_t_wi,
  "final internal table and workarea
  lt_final       TYPE TABLE OF ty_final,
  ls_final       TYPE ty_final,
  "internal table for workitem-id
  lt_workitem    TYPE TABLE OF sww_wiid,
  "internal table for agent
  lt_agent       TYPE TABLE OF swr_wiagent,

  gt_return      TYPE TABLE OF ddshretval,
  gwa_return     TYPE ddshretval,
  gwa_dynpfields TYPE dynpread,
  gt_dynpfields  TYPE TABLE OF dynpread,
  gv_user        TYPE usmd120c-usmd_created_by.
