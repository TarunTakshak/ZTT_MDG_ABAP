*&---------------------------------------------------------------------*
*& Report ZTT_PRG_UPDATE_MODIFY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_update_modify.

TYPES : BEGIN OF ty_sflight,
          carrid   TYPE s_carr_id,     "airline code
          connid   TYPE s_conn_id,     "flight connection number
          fldate   TYPE s_date,        "flight date
          price    TYPE s_price,       "airfare
          currency TYPE s_currcode,    "local currency of airline
        END OF ty_sflight.
DATA : lt_flight  TYPE TABLE OF  ty_sflight,   "new internal table
       ls_sflight TYPE ty_sflight,
       lv_tabix   TYPE sy-tabix VALUE 1.

FIELD-SYMBOLS <fs_modify> TYPE ty_sflight.
"abap system field: row index of internal tables
*"--------------------------------------------------------------------*
* START OF SELECTION EVENT *
*"--------------------------------------------------------------------*
START-OF-SELECTION.
  SELECT carrid
  connid
  fldate
  price
  currency
  FROM sflight INTO TABLE lt_flight UP TO 10 ROWS.
  IF sy-subrc <> 0 AND lt_flight IS INITIAL .
    MESSAGE 'DATA NOT FOUND' TYPE 'E'.
  ENDIF.                               "IF sy-subrc <> 0 AND lt_flight IS INITIAL .
*"--------------------------------------------------------------------*
* END OF SELECTION EVENT *
*"--------------------------------------------------------------------*
END-OF-SELECTION.
  LOOP AT lt_flight ASSIGNING <fs_modify>.
    IF lv_tabix MOD 2 EQ 0.
*      lt_flight[ lv_tabix ]-price = 123.
      <fs_modify>-price = 123.

    ENDIF.
    lv_tabix = lv_tabix + 1.

    WRITE : / <fs_modify>-carrid,
              <fs_modify>-connid,
              <fs_modify>-fldate,
              <fs_modify>-price,
              <fs_modify>-currency.

  ENDLOOP.
