*&---------------------------------------------------------------------*
*& Include          ZTT_SELECTION_SCREEN
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
  SELECTION-SCREEN COMMENT 2(20) cm1.
  PARAMETERS : p_rb1 RADIOBUTTON GROUP rb1 USER-COMMAND uc1 DEFAULT 'X',
               p_rb2 RADIOBUTTON GROUP rb1,
               p_rb3 RADIOBUTTON GROUP rb1,
               p_tab TYPE tabname MODIF ID mo1,
               p_fld TYPE fieldname MODIF ID mo3.
SELECTION-SCREEN END OF BLOCK b1.


*&---------------------------------------------------------------------*
*& Form modify_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify_screen .


  LOOP AT SCREEN.

    IF ( p_rb1 EQ abap_true OR  p_rb2 EQ abap_true ) AND screen-group1 = 'MO1'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF p_rb3 EQ abap_true.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF ( p_rb1 EQ ' ' OR  p_rb2 EQ ' ' )  AND screen-group1 = 'MO3'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ENDIF.
  ENDLOOP.                             "LOOP AT SCREEN.


ENDFORM.
