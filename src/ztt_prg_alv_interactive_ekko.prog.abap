*&---------------------------------------------------------------------*
*& REPORT ZTT_PRG_ALV_INTERACTIVE_EKKO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_alv_interactive_ekko.

*include to hold data delcartions
INCLUDE ztt_prg_alv_interactive_top.
*include for main logic
INCLUDE ztt_prg_alv_interactive_main.
*"--------------------------------------------------------------------*
* START OF SELECTION EVENT *
*"--------------------------------------------------------------------*
START-OF-SELECTION.
*perform to hold purchasing header details
  PERFORM get_ekko.
*perform for field-catlog purchasing header details
  PERFORM field_catlog_ekko.
*perform to display purchasing header details
  PERFORM display_ekko.
