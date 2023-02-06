*&---------------------------------------------------------------------*
*& Report ZTT_PRG_CR_STATUS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_cr_status.

**********************************************************************
* Developer ID: TAKSHAKT
* Created Date: 11.11.2022
* Transport ID:
**********************************************************************
*                         Descriptive Logic                          *
**********************************************************************
*
*
*
*
**********************************************************************
*                          Change History                            *
**********************************************************************
* Changed By * Changed Date * Transport ID * Reason for Change / Id  *
**********************************************************************
*            *              *              *                         *
*            *              *              *                         *
**********************************************************************


"incude for selection screen
INCLUDE ztt_prg_cr_status_top.
"include for class def and impl
INCLUDE ztt_prg_cr_status_class.
"include for search-help
INCLUDE ztt_prg_search_help.
"start of selection

START-OF-SELECTION.
  "include for bussiness logic
  INCLUDE ztt_prg_cr_status_main.
  "include to display data
  INCLUDE ztt_prg_cr_status_output.
