*&---------------------------------------------------------------------*
*& REPORT ZTT_PRG_USD_ALV_INTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_usd_alv_inter.
                                       "INCLUDE FOR STRUCTURE DECLARTIONS
INCLUDE ztt_prg_usd_alv_inter_str.
                                       "INCLUDE FOR MAIN PROGRAM
INCLUDE ztt_prg_usd_alv_inter_main.
*"--------------------------------------------------------------------*
* START OF SELECTION EVENT *
*"--------------------------------------------------------------------*
START-OF-SELECTION.
                                       "PERFORM TO FETCH DATA FROM DATABASE
  PERFORM get_request.
                                       "PERFORM FOR FIELD CATLOG
  PERFORM field_catlog.

End-of-SELECTION.
                                       "PERFORM TO DISPLAY DATA
  PERFORM display_request.
