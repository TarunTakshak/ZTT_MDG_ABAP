*&---------------------------------------------------------------------*
*& INCLUDE ZTT_PRG_REFERNCE_DATA_MAIN
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& FORM DIS_OUTPUT
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM dis_output .
  LOOP AT SCREEN.
    IF ( pv_tab EQ abap_true OR pv_str EQ abap_true ) AND screen-group1 = 'MO1'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF pv_fild EQ abap_true.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF ( pv_tab EQ ' ' OR pv_str EQ ' ' ) AND screen-group1 = 'MO1'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF ( pv_de EQ abap_true OR pv_dm EQ abap_true ) AND screen-group1 = 'MO2'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF ( pv_de EQ ' ' OR pv_dm EQ ' ' ) AND screen-group1 = 'MO2'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ENDIF.                             "IF ( pv_tab EQ abap_true OR pv_str EQ abap_true )
  ENDLOOP.                             "LOOP AT SCREEN.
ENDFORM.                               "FORM dis_output .

*&---------------------------------------------------------------------*
*& FORM GET_TABLE
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*
FORM get_table .
  SELECT dd03l~tabname
         dd03l~fieldname
         dd03l~rollname
         dd01l~entitytab
    INTO TABLE lt_tab
    FROM dd03l INNER JOIN dd01l
      ON dd03l~domname = dd01l~domname
   INNER JOIN dd02l
      ON dd02l~tabname = dd03l~tabname
   WHERE dd03l~tabname = pv_table AND dd02l~tabclass = 'TRANSP'.
  IF sy-subrc <> 0 AND lt_tab IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_tab IS INITIAL.
  LOOP AT lt_tab ASSIGNING <fs_mod>.
    IF <fs_mod>-entitytab IS INITIAL.
      <fs_mod>-entitytab = 'N/A'.
    ENDIF.                             "IF <fs_mod>-entitytab IS INITIAL.
  ENDLOOP.                             "LOOP AT lt_tab ASSIGNING <fs_mod>.
ENDFORM.                               "FORM get_table .

*&---------------------------------------------------------------------*
*& FORM FIELD_CAT
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
FORM field_cat .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'TABNAME'.
  ls_fcat-seltext_m = 'TABNAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'FIELDNAME'.
  ls_fcat-seltext_m = 'FIELDNAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'ROLLNAME'.
  ls_fcat-seltext_m = 'DATA ELEMENT'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 4.
  ls_fcat-fieldname = 'ENTITYTAB'.
  ls_fcat-seltext_m = 'VALUE TABLE'.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_cat .
*&---------------------------------------------------------------------*
*& FORM TAB_DIS
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM tab_dis .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
*     I_CALLBACK_TOP_OF_PAGE = ' '
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.
  CLEAR ls_tab.
  REFRESH lt_tab.
ENDFORM.                               "FORM tab_dis .
*&---------------------------------------------------------------------*
*& FORM GET_DE
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM get_de .
  SELECT
        dd03l~rollname
        dd01l~domname
        dd01l~entitytab
   INTO CORRESPONDING FIELDS OF TABLE lt_tab
   FROM dd03l
  INNER JOIN dd01l
     ON dd03l~domname = dd01l~domname
  WHERE rollname = pv_field.

  IF sy-subrc <> 0 AND lt_tab IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    DELETE ADJACENT DUPLICATES FROM lt_tab COMPARING rollname domname.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_tab IS INITIAL.
  LOOP AT lt_tab ASSIGNING <fs_mod>.
    IF <fs_mod>-entitytab IS INITIAL.
      <fs_mod>-entitytab = 'N/A'.
    ENDIF.                             "IF <fs_mod>-entitytab IS INITIAL.
  ENDLOOP.                             "LOOP AT lt_tab ASSIGNING <fs_mod>.
ENDFORM.                               "FORM get_de .
*&---------------------------------------------------------------------*
*& FORM FIELD_CAT_DE
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_cat_de .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'ROLLNAME'.
  ls_fcat-seltext_m = 'DATA ELEMENT'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'DOMNAME'.
  ls_fcat-seltext_m = 'DOMAIN NAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'ENTITYTAB'.
  ls_fcat-seltext_m = 'VALUE TABLE'.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_cat_de .
*&---------------------------------------------------------------------*
*& FORM DE_DIS
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM de_dis .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
   " I_CALLBACK_TOP_OF_PAGE = ' '
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.
  CLEAR ls_tab.
  REFRESH lt_tab.
ENDFORM.                               "FORM de_dis .
*&---------------------------------------------------------------------*
*& FORM GET_DOMAIN
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM get_domain .
  SELECT
         dd01l~domname
         dd01l~entitytab
    INTO CORRESPONDING FIELDS OF TABLE lt_tab
    FROM dd03l
   INNER JOIN dd01l
      ON dd03l~domname = dd01l~domname
   WHERE dd01l~domname = pv_field.

  IF sy-subrc <> 0 AND lt_tab IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    DELETE ADJACENT DUPLICATES FROM lt_tab COMPARING domname.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_tab IS INITIAL.
  LOOP AT lt_tab ASSIGNING <fs_mod>.
    IF <fs_mod>-entitytab IS INITIAL.
      <fs_mod>-entitytab = 'N/A'.
    ENDIF.                             "IF <fs_mod>-entitytab IS INITIAL.
  ENDLOOP.                             "LOOP AT lt_tab ASSIGNING <fs_mod>.
ENDFORM.                               "FORM get_domain .
*&---------------------------------------------------------------------*
*& FORM FIELD_CAT_DOM
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_cat_dom .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'DOMNAME'.
  ls_fcat-seltext_m = 'DOMAIN NAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'ENTITYTAB'.
  ls_fcat-seltext_m = 'VALUE TABLE'.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_cat_dom .
*&---------------------------------------------------------------------*
*& FORM DOM_DIS
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM dom_dis .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
  " I_CALLBACK_TOP_OF_PAGE = ' ' =
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.
  CLEAR ls_fcat.
  REFRESH lt_fcat.
ENDFORM.                               "FORM dom_dis .
*&---------------------------------------------------------------------*
*& FORM GET_STR
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM get_str .
  SELECT dd03l~tabname
         dd03l~fieldname
         dd03l~rollname
         dd01l~entitytab
    INTO TABLE lt_tab
    FROM dd03l
   INNER JOIN dd01l
      ON dd03l~domname = dd01l~domname
   INNER JOIN dd02l
      ON dd02l~tabname = dd03l~tabname
   WHERE dd03l~tabname = pv_table
     AND dd02l~tabclass = 'INTTAB'.

  IF sy-subrc <> 0 AND lt_tab IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_tab IS INITIAL.
  LOOP AT lt_tab ASSIGNING <fs_mod>.
    IF <fs_mod>-entitytab IS INITIAL.
      <fs_mod>-entitytab = 'N/A'.
    ENDIF.                             "IF <fs_mod>-entitytab IS INITIAL.
  ENDLOOP.                             "LOOP AT lt_tab ASSIGNING <fs_mod>.
ENDFORM.                               "FORM get_str .
*&---------------------------------------------------------------------*
*& FORM FIELD_CAT_STR
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_cat_str .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'TABNAME'.
  ls_fcat-seltext_m = 'TABNAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'FIELDNAME'.
  ls_fcat-seltext_m = 'FIELDNAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'ROLLNAME'.
  ls_fcat-seltext_m = 'DATA ELEMENT'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 4.
  ls_fcat-fieldname = 'ENTITYTAB'.
  ls_fcat-seltext_m = 'VALUE TABLE'.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_cat_str .
*&---------------------------------------------------------------------*
*& FORM STR_DIS
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM str_dis .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
   " I_CALLBACK_TOP_OF_PAGE = ' '
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.
  CLEAR ls_tab.
  REFRESH lt_tab.
ENDFORM.                               "FORM str_dis .
*&---------------------------------------------------------------------*
*& FORM GET_FIELD
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM get_field .
  SELECT dd03l~tabname
         dd03l~fieldname
         dd03l~rollname
         dd01l~entitytab
    INTO TABLE lt_tab
    FROM dd03l
   INNER JOIN dd01l
      ON dd03l~domname = dd01l~domname
   INNER JOIN dd02l
      ON dd02l~tabname = dd03l~tabname
   WHERE dd03l~tabname = pv_table
     AND dd03l~fieldname = pv_field
     AND dd02l~tabclass = 'TRANSP'.

  IF sy-subrc <> 0 AND lt_tab IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_tab IS INITIAL.
  LOOP AT lt_tab ASSIGNING <fs_mod>.
    IF <fs_mod>-entitytab IS INITIAL.
      <fs_mod>-entitytab = 'N/A'.
    ENDIF.                             "IF <fs_mod>-entitytab IS INITIAL.
  ENDLOOP.                             "LOOP AT lt_tab ASSIGNING <fs_mod>.
ENDFORM.                               "FORM get_field .
*&---------------------------------------------------------------------*
*& FORM FIELD_CAT_FLD
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_cat_fld .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'TABNAME'.
  ls_fcat-seltext_m = 'TABNAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'FIELDNAME'.
  ls_fcat-seltext_m = 'FIELDNAME'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'ROLLNAME'.
  ls_fcat-seltext_m = 'DATA ELEMENT'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 4.
  ls_fcat-fieldname = 'ENTITYTAB'.
  ls_fcat-seltext_m = 'VALUE TABLE'.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_cat_fld .
*&---------------------------------------------------------------------*
*& FORM FLD_DIS
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM fld_dis .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
    " I_CALLBACK_TOP_OF_PAGE = ' '
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.
  CLEAR ls_tab.
  REFRESH lt_tab.
ENDFORM.                               "FORM fld_dis .
