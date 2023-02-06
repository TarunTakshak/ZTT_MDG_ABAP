*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_DATA_R_MAIN
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_table
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_table .


  SELECT  dd03l~tabname
          dd03l~fieldname
          dd03l~rollname
          dd01l~entitytab
     FROM dd03l
    INNER JOIN dd01l ON dd03l~domname = dd01l~domname
    INNER JOIN dd02l ON dd03l~tabname = dd02l~tabname
     INTO TABLE lt_tab
    WHERE dd03l~tabname EQ p_tab
      AND dd02l~tabclass = 'TRANSP'.

  IF sy-subrc IS NOT INITIAL AND lt_tab IS INITIAL.
    MESSAGE E010(ztt_msg_rerfernce) WITH p_tab.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form fcat_tab
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fcat_tab .

  lt_fcat =  VALUE #( ( col_pos = '1' fieldname = 'TABNAME' seltext_m = 'TABLE NAME')
                      ( col_pos = '2' fieldname = 'FIELDNAME' seltext_m = 'Field Name')
                      ( col_pos = '3' fieldname = 'ROLLNAME' seltext_m = 'DATA ELEMENT')
                      ( col_pos = '4' fieldname = 'ENTITYTAB' seltext_m = 'VALUE TABLE')
  ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_table
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_table .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.

  REFRESH : lt_tab , lt_fcat.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form get_str
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_str .


  SELECT  dd03l~tabname
          dd03l~fieldname
          dd03l~rollname
          dd01l~entitytab
     FROM dd03l
    INNER JOIN dd01l ON dd03l~domname = dd01l~domname
    INNER JOIN dd02l ON dd03l~tabname = dd02l~tabname
     INTO TABLE lt_tab
    WHERE dd03l~tabname EQ p_tab
      AND dd02l~tabclass = 'INTTAB'.

  IF sy-subrc IS NOT INITIAL AND lt_tab IS INITIAL.

    MESSAGE e011(ztt_msg_rerfernce) WITH p_tab.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form fcat_str
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fcat_str .

  lt_fcat =  VALUE #( ( col_pos = '1' fieldname = 'TABNAME' seltext_m = 'TABLE NAME')
                      ( col_pos = '2' fieldname = 'FIELDNAME' seltext_m = 'Field Name')
                      ( col_pos = '3' fieldname = 'ROLLNAME' seltext_m = 'DATA ELEMENT')
                      ( col_pos = '4' fieldname = 'ENTITYTAB' seltext_m = 'VALUE TABLE')
  ).


ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_str
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_str .


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.

  REFRESH : lt_tab , lt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_tab_str
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_tab_str .


  SELECT  dd03l~tabname
            dd03l~fieldname
            dd03l~rollname
            dd01l~entitytab
       FROM dd03l
      INNER JOIN dd01l ON dd03l~domname = dd01l~domname
      INNER JOIN dd02l ON dd03l~tabname = dd02l~tabname
       INTO TABLE lt_tab
      WHERE dd03l~tabname EQ p_tab AND dd03l~fieldname EQ p_fld.

  IF sy-subrc IS NOT INITIAL AND lt_tab IS INITIAL.
    MESSAGE e012(ztt_msg_rerfernce).
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form fcat_t_s
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM fcat_t_s .

  lt_fcat =  VALUE #( ( col_pos = '1' fieldname = 'TABNAME' seltext_m = 'TABLE NAME')
                       ( col_pos = '2' fieldname = 'FIELDNAME' seltext_m = 'Field Name')
                       ( col_pos = '3' fieldname = 'ROLLNAME' seltext_m = 'DATA ELEMENT')
                       ( col_pos = '4' fieldname = 'ENTITYTAB' seltext_m = 'VALUE TABLE')
   ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_t_s
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_t_s .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_tab.

  REFRESH : lt_tab , lt_fcat.


ENDFORM.
