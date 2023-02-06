*&---------------------------------------------------------------------*
*& Include          ZTT_CUST_MODIFY_SCREEN
*&---------------------------------------------------------------------*



  LOOP AT SCREEN.
    IF rb_crt EQ 'X' AND screen-group1 = 'MO1'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_upd EQ 'X' AND screen-group1 = 'MO2'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_dlt EQ 'X' AND screen-group1 = 'MO3'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_read EQ 'X' AND screen-group1 = 'MO4'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_crt EQ ' ' AND screen-group1 = 'MO1'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_upd EQ ' ' AND screen-group1 = 'MO2'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_dlt EQ ' ' AND screen-group1 = 'MO3'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ELSEIF rb_read EQ ' ' AND screen-group1 = 'MO4'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.
    ENDIF.
  ENDLOOP.
