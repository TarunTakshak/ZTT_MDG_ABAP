*&---------------------------------------------------------------------*
*& INCLUDE ZTT_PRG_USD_ALV_INTER_MAIN
*&---------------------------------------------------------------------*

*"--------------------------------------------------------------------*
*FORM get_request .                                                   *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM get_request .
  SELECT usmd_creq_type INTO TABLE lt_usmd110c FROM usmd110c WHERE usmd_creq_type IN s_req.
  IF sy-subrc <> 0 AND lt_usmd110c IS INITIAL.
    MESSAGE 'DATA NOT FOUND' TYPE 'E'.
  ELSE.
    IF lt_usmd110c IS NOT INITIAL.
      SELECT usmd_creq_type
             txtmi
        FROM usmd110t
        INTO TABLE lt_t
         FOR ALL ENTRIES IN lt_usmd110c
       WHERE usmd_creq_type = lt_usmd110c-usmd_creq_type
         AND langu = 'E'.

      IF lt_t IS NOT INITIAL.
        LOOP AT lt_t INTO ls_t.
          READ TABLE lt_usmd110c INTO ls_usmd110c WITH KEY usmd_creq_type = ls_t-usmd_creq_type.
          ls_final-usmd_creq_type = ls_usmd110c-usmd_creq_type.
          ls_final-txtmi = ls_t-txtmi.
          APPEND ls_final TO lt_final.
          CLEAR ls_final.
        ENDLOOP.                       "LOOP AT lt_t INTO ls_t.
      ENDIF.                           "IF lt_t IS NOT INITIAL.
    ENDIF.                             "IF lt IS NOT INITIAL.
  ENDIF.                               "IF sy-subrc <> 0 AND lt IS INITIAL.
ENDFORM.                               "FORM get_request .
*&---------------------------------------------------------------------*
*& FORM FIELD_CATLOG
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*
*FORM field_catlog .                                                  *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM field_catlog .
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'USMD_CREQ_TYPE'.
  ls_fcat-seltext_m = 'TYPE OF CHANGE REQUEST'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'TXTMI'.
  ls_fcat-seltext_m = 'DESCRIPTION'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_layout-colwidth_optimize = 'X'.
  ls_layout-zebra = 'X'.
ENDFORM.                               "FORM field_catlog .
*&---------------------------------------------------------------------*
*& FORM DISPLAY_REQUEST
*&---------------------------------------------------------------------*
*& TEXT
*&---------------------------------------------------------------------*
*& --> P1 TEXT
*& <-- P2 TEXT
*&---------------------------------------------------------------------*
*"--------------------------------------------------------------------*
*FORM display_request .                                               *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM display_request .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      is_layout               = ls_layout
      it_fieldcat             = lt_fcat
    TABLES
      t_outtab                = lt_final.
ENDFORM.                               "FORM display_request .
*"--------------------------------------------------------------------*
*FORM user_command USING r_ucom LIKE sy-ucomm                         *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM user_command USING r_ucom LIKE sy-ucomm
r_selfield TYPE slis_selfield.
  CASE r_ucom.
    WHEN '&IC1'.
      READ TABLE lt_final INTO ls_final INDEX r_selfield-tabindex.

      SELECT usmd120c~usmd_crequest
             usmd120c~usmd_creq_type
             usmd120c~usmd_creq_status
             usmd120c~usmd_creq_text
             usmd120c~usmd_created_by
             usmd110t~txtmi
        INTO TABLE lt_c
        FROM usmd120c
       INNER JOIN usmd110t
          ON usmd120c~usmd_creq_type = usmd110t~usmd_creq_type
       WHERE usmd120c~usmd_creq_type = ls_final-usmd_creq_type
        AND langu = 'E'.

      IF sy-subrc <> 0 AND lt_usmd110c IS INITIAL.
        MESSAGE 'DATA NOT FOUND' TYPE 'E'.
      ELSE.
        PERFORM fcat_inter.
      ENDIF.                           "IF sy-subrc <> 0 AND lt IS INITIAL.
  ENDCASE.                             "CASE r_ucom.
ENDFORM.                               "FORM user_command USING r_ucom LIKE sy-ucomm

*"--------------------------------------------------------------------*
*FORM fcat_inter .                                                    *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM fcat_inter .
  CLEAR ls_fcat.
  REFRESH lt_fcat.
  ls_fcat-col_pos = 1.
  ls_fcat-fieldname = 'USMD_CREQUEST'.
  ls_fcat-seltext_m = 'CHANGE REQUEST'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'TXTMI'.
  ls_fcat-seltext_m = 'DESC'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'USMD_CREQ_TYPE'.
  ls_fcat-seltext_m = 'TYPE OF CHANGE REQUEST'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_fcat-col_pos = 4.
  ls_fcat-fieldname = 'USMD_CREQ_STATUS'.
  ls_fcat-seltext_m = 'STATUS OF CHANGE REQUEST'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_fcat-col_pos = 5.
  ls_fcat-fieldname = 'USMD_CREQ_TEXT'.
  ls_fcat-seltext_m = 'DESCRIPTION'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_fcat-col_pos = 6.
  ls_fcat-fieldname = 'USMD_CREATED_BY'.
  ls_fcat-seltext_m = 'USER NAME IN USER MASTER RECORD'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR ls_fcat.
  ls_layout-colwidth_optimize = 'X'.
  ls_layout-zebra = 'X'.
  PERFORM display_change.
ENDFORM.                               "FORM fcat_inter .

*"--------------------------------------------------------------------*
*FORM display_change .                                                *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
*& TEXT *
*"&-------------------------------------------------------------------*
FORM display_change .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET = ' '
*     I_CALLBACK_USER_COMMAND = ' '
*     I_CALLBACK_TOP_OF_PAGE = ' '
      is_layout          = ls_layout
      it_fieldcat        = lt_fcat
    TABLES
      t_outtab           = lt_c.
ENDFORM.                               "FORM display_change .
