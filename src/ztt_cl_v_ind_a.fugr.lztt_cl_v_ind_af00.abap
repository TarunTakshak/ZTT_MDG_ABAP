*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZTT_CL_V_IND_A..................................*
FORM GET_DATA_ZTT_CL_V_IND_A.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTT_CL_INDEPE_A WHERE
(VIM_WHERETAB) .
    CLEAR ZTT_CL_V_IND_A .
ZTT_CL_V_IND_A-ACCOUNT_NO =
ZTT_CL_INDEPE_A-ACCOUNT_NO .
ZTT_CL_V_IND_A-ID =
ZTT_CL_INDEPE_A-ID .
ZTT_CL_V_IND_A-BRANCH_ID =
ZTT_CL_INDEPE_A-BRANCH_ID .
<VIM_TOTAL_STRUC> = ZTT_CL_V_IND_A.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZTT_CL_V_IND_A .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZTT_CL_V_IND_A.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZTT_CL_V_IND_A-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTT_CL_INDEPE_A WHERE
  ACCOUNT_NO = ZTT_CL_V_IND_A-ACCOUNT_NO .
    IF SY-SUBRC = 0.
    DELETE ZTT_CL_INDEPE_A .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTT_CL_INDEPE_A WHERE
  ACCOUNT_NO = ZTT_CL_V_IND_A-ACCOUNT_NO .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTT_CL_INDEPE_A.
    ENDIF.
ZTT_CL_INDEPE_A-ACCOUNT_NO =
ZTT_CL_V_IND_A-ACCOUNT_NO .
ZTT_CL_INDEPE_A-ID =
ZTT_CL_V_IND_A-ID .
ZTT_CL_INDEPE_A-BRANCH_ID =
ZTT_CL_V_IND_A-BRANCH_ID .
    IF SY-SUBRC = 0.
    UPDATE ZTT_CL_INDEPE_A ##WARN_OK.
    ELSE.
    INSERT ZTT_CL_INDEPE_A .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZTT_CL_V_IND_A-UPD_FLAG,
STATUS_ZTT_CL_V_IND_A-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZTT_CL_V_IND_A.
  SELECT SINGLE * FROM ZTT_CL_INDEPE_A WHERE
ACCOUNT_NO = ZTT_CL_V_IND_A-ACCOUNT_NO .
ZTT_CL_V_IND_A-ACCOUNT_NO =
ZTT_CL_INDEPE_A-ACCOUNT_NO .
ZTT_CL_V_IND_A-ID =
ZTT_CL_INDEPE_A-ID .
ZTT_CL_V_IND_A-BRANCH_ID =
ZTT_CL_INDEPE_A-BRANCH_ID .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZTT_CL_V_IND_A USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZTT_CL_V_IND_A-ACCOUNT_NO TO
ZTT_CL_INDEPE_A-ACCOUNT_NO .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTT_CL_INDEPE_A'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTT_CL_INDEPE_A TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTT_CL_INDEPE_A'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
