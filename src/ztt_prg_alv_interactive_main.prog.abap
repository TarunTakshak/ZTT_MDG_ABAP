*&---------------------------------------------------------------------*
*& INCLUDE ZTT_PRG_ALV_INTERACTIVE_MAIN
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& FORM GET_EKKO
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
FORM get_ekko.
  SELECT ebeln
  bukrs
  bstyp
  bsart
  FROM ekko INTO TABLE lt_ekko WHERE ebeln IN s_ebeln.
  IF sy-subrc <> 0 AND lt_ekko IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_ekko IS INITIAL.
ENDFORM.                               "FORM get_ekko .
*&---------------------------------------------------------------------*
*& FORM FIELD_CATLOG_EKKO
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_catlog_ekko .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'EBELN'.
  ls_fcat-seltext_m = 'PURCHASING DOCUMENT NUMBER'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'BUKRS'.
  ls_fcat-seltext_m = 'COMPANY CODE'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'BSTYP'.
  ls_fcat-seltext_m = 'PURCHASING DOCUMENT CATEGORY'.
  APPEND ls_fcat TO lt_fcat.
  ls_fcat-col_pos = 4.
  ls_fcat-fieldname = 'BSART'.
  ls_fcat-seltext_m = 'PURCHASING DOCUMENT TYPE'.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_catlog_ekko .
*&---------------------------------------------------------------------*
*& FORM DISPLAY_EKKO
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*

FORM display_ekko .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_top_of_page  = 'TOP_OF_PAGE'
      i_callback_user_command = 'USER_COMMAND'
      it_fieldcat             = lt_fcat
    TABLES
      t_outtab                = lt_ekko.
ENDFORM.                               "FORM display_ekko .
*"--------------------------------------------------------------------*
*FORM top_of_page.                                                    *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM top_of_page.
  REFRESH lt_header.
  ls_header-typ = 'H'.
  ls_header-info = 'PURCHASING DOCUMENT HEADER'.
  APPEND ls_header TO lt_header.
  CLEAR ls_header.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.
ENDFORM.                               "FORM top_of_page.
*"--------------------------------------------------------------------*
*FORM user_command USING r_ucomm TYPE sy-ucomm                        *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM user_command USING r_ucomm TYPE sy-ucomm
r_selfield TYPE slis_selfield.
  CASE r_ucomm.
    WHEN '&IC1' .
      READ TABLE lt_ekko INTO ls_ekko INDEX r_selfield-tabindex.
      PERFORM get_ekpo.
      PERFORM field_catlog_ekpo.
      PERFORM display_ekpo.
  ENDCASE.                             "CASE r_ucomm.
ENDFORM.                               "FORM user_command USING r_ucomm TYPE sy-ucomm
*&---------------------------------------------------------------------*
*& FORM GET_EKPO
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT

FORM get_ekpo .
  SELECT ebeln
  loekz
  statu
  aedat
  FROM ekpo INTO TABLE lt_ekpo WHERE ebeln = ls_ekko-ebeln.
  IF sy-subrc <> 0 AND lt_ekpo IS INITIAL.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'W' NUMBER '000'.
  ELSE.
    MESSAGE ID 'ZTT_MSG_RERFERNCE' TYPE 'I' NUMBER '001'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_ekpo IS INITIAL.
ENDFORM.                               "FORM get_ekpo .
*&---------------------------------------------------------------------*
*& FORM FIELD_CATLOG_EKPO
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_catlog_ekpo .
  REFRESH lt_fcat.
  CLEAR ls_fcat.
  PERFORM field_cat USING '1' 'EBELN' 'PURCHASING DOCUMENT NUMBER'.
  PERFORM field_cat USING '2' 'LOEKZ' 'DELETION INDICATOR IN PURCHASING DOCUMENT'.
  PERFORM field_cat USING '3' 'STATU' 'ORIGIN OF A PURCHASING DOCUMENT ITEM'.
  PERFORM field_cat USING '4' 'AEDAT' 'PURCHASING DOCUMENT ITEM CHANGE DATE'.
ENDFORM.                               "FORM field_catlog_ekpo .
*&---------------------------------------------------------------------*
*& FORM FIELD_CAT
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P_
*& --> P_
*& --> P_
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM field_cat USING VALUE(p_01)
VALUE(p_02)
VALUE(p_03).
  ls_fcat-col_pos = p_01.
  ls_fcat-fieldname = p_02.
  ls_fcat-seltext_m = p_03.
  APPEND ls_fcat TO lt_fcat.
ENDFORM.                               "FORM field_cat USING VALUE(p_01)
*&---------------------------------------------------------------------*
*& FORM DISPLAY_EKPO
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*

FORM display_ekpo .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program     = sy-repid
      i_callback_top_of_page = 'TOP'
      it_fieldcat            = lt_fcat
    TABLES
      t_outtab               = lt_ekpo.
ENDFORM.                               "FORM display_ekpo .
*"--------------------------------------------------------------------*
*FORM top.                                                            *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM top.
  REFRESH lt_header.
  ls_header-typ = 'H'.
  ls_header-info = 'PURCHASING DOCUMENT ITEM'.
  APPEND ls_header TO lt_header.
  CLEAR ls_header.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.
ENDFORM.                               "FORM top.
