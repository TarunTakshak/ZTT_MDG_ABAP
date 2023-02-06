*&---------------------------------------------------------------------*
*& Report ZTT_PRG_DATA_R
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_data_r.

**********************************************************************
*include to hold structure
**********************************************************************
INCLUDE ztt_prg_data_r_top.

**********************************************************************
*include for slection screen
**********************************************************************
INCLUDE ztt_selection_screen.

**********************************************************************
*include for main logic
**********************************************************************
INCLUDE ztt_prg_data_r_main.

AT SELECTION-SCREEN OUTPUT.
*perfrom for modify screen
  PERFORM modify_screen.

*business logic
START-OF-SELECTION.

  IF p_rb1 EQ abap_true.
*perfrom to get table data
    PERFORM get_table.
*perform for field-catlog
    PERFORM fcat_tab.
*perform to display table data
    PERFORM display_table.

  ELSEIF p_rb2 EQ abap_true.
*perfrom to get structure data
    PERFORM get_str.
*perform for field-catlog
    PERFORM fcat_str.
*perform to display str data
    PERFORM display_str.

  ELSEIF p_rb3 EQ abap_true.
*perfrom to get table & structure data
    PERFORM get_tab_str.
*perfrom for field catlog
    PERFORM fcat_t_s.
*perform to display table str
    PERFORM display_t_s.

  ENDIF.

END-OF-SELECTION.
  FREE MEMORY.
