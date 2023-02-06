*&---------------------------------------------------------------------*
*& REPORT ZTT_PRG_SFLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_sflight.
TYPES : BEGIN OF ty_sflight,
          carrid   TYPE s_carr_id,     "airline code
          connid   TYPE s_conn_id,     "flight connection number
          fldate   TYPE s_date,        "flight date
          price    TYPE s_price,       "airfare
          currency TYPE s_currcode,    "local currency of airline
        END OF ty_sflight.
DATA : lt_sflight TYPE TABLE OF ty_sflight,   "old internal table
       lt_flight  TYPE TABLE OF ty_sflight,   "new internal table
       ls_sflight TYPE ty_sflight,
       lv_tabix   TYPE sy-tabix VALUE 1.
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
  LOOP AT lt_flight INTO ls_sflight.
    IF lv_tabix MOD 2 NE 0.
          lt_sflight = value #( BASE  lt_sflight ( ls_sflight ) ).
      WRITE : / ls_sflight-carrid,
      ls_sflight-connid,
      ls_sflight-fldate,
      ls_sflight-price,
      ls_sflight-currency.
    ENDIF.                             "IF lv_tabix MOD 2 NE 0.
    lv_tabix = lv_tabix + 1.
  ENDLOOP.                             "LOOP AT lt_sflight INTO ls_sflight.
