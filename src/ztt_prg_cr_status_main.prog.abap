*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_CR_STATUS_MAIN
*&---------------------------------------------------------------------*


*data declartion for local object
DATA(lo_cr) = NEW lc_cr_data( ).


**********************************************************************
*method to get the details of cr status
**********************************************************************


call method lo_cr->get_cr
exporting
  i_cr_type = p_crtype
importing
  et_cr     = data(lt_cr_type).

LOOP AT lt_cr_type INTO DATA(ls_cr).

**********************************************************************
*method to get top workfitem id
**********************************************************************
CALL METHOD cl_usmd_wf_service=>get_cr_top_wf
  EXPORTING
    id_crequest = ls_cr-usmd_crequest"ls_temp-usmd_crequest. "Change Request
  IMPORTING
    et_workflow = lt_t_wid.

" LOOP AT lt_t_wid INTO DATA(ls_t_swid).
READ TABLE lt_t_wid INTO DATA(ls_t_swid) INDEX 1.
DATA(ls) = ls_t_swid-wi_id.
APPEND ls TO lt_wfid.

**********************************************************************
*method to get sub-workitem-id by top wid
**********************************************************************
CALL METHOD cl_usmd_wf_service=>get_wi_by_topwi
  EXPORTING
    it_topwi    = lt_wfid              " Workitems
  RECEIVING
    rt_workitem = lt_swid.             " Workflow: Tabelle mit Workitems



LOOP AT lt_swid INTO DATA(ls_s_wid).
  DATA(ls_wrkitem) = ls_s_wid-wi_id.
  APPEND ls_wrkitem TO lt_workitem.



**********************************************************************
*function module to get agents
**********************************************************************
  CALL FUNCTION 'SAP_WAPI_GET_WI_AGENTS'
    EXPORTING
      workitems = lt_workitem
    IMPORTING
      wi_agents = lt_agent.

  READ TABLE lt_agent INTO  DATA(ls_agent) WITH KEY ls_s_wid-wi_id.

  SELECT wi_aagent FROM swwwihead INTO @DATA(lv_temp) WHERE wi_id = @ls_s_wid-wi_id.
  ENDSELECT.

  IF lv_temp IS INITIAL.

    DATA: ls_user LIKE  addr3_val.

    IF lt_agent IS NOT INITIAL.
      CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
        EXPORTING
          user_name    = ls_agent-user
        IMPORTING
          user_address = ls_user.

      ls_final-usmd_crequest       =   ls_cr-usmd_crequest.
      ls_final-usmd_creq_type      =   ls_cr-usmd_creq_type .
      ls_final-usmd_creq_status    =   ls_cr-usmd_creq_status.
      ls_final-usmd_created_by     =   ls_cr-usmd_created_by.
      ls_final-txtmi               =   ls_cr-txtmi.
      ls_final-wi_agnt             =   ls_user-name_text."ls_agent-user.
      APPEND ls_final TO lt_final.
      CLEAR ls_final.


    ENDIF.

  ENDIF.


ENDLOOP.                           "loop at lt_cr_type....

CLEAR : ls_wrkitem, ls_agent, ls_s_wid,ls_t_swid,ls_cr.
REFRESH : lt_workitem,lt_swid,lt_agent,lt_wfid,lt_t_wid.

ENDLOOP.                             "loop at lt_twid...
"ENDLOOP.
