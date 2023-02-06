*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTT_CL_V_DEPE_A.................................*
TABLES: ZTT_CL_V_DEPE_A, *ZTT_CL_V_DEPE_A. "view work areas
CONTROLS: TCTRL_ZTT_CL_V_DEPE_A
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZTT_CL_V_DEPE_A. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZTT_CL_V_DEPE_A.
* Table for entries selected to show on screen
DATA: BEGIN OF ZTT_CL_V_DEPE_A_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZTT_CL_V_DEPE_A.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZTT_CL_V_DEPE_A_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZTT_CL_V_DEPE_A_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZTT_CL_V_DEPE_A.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZTT_CL_V_DEPE_A_TOTAL.

*.........table declarations:.................................*
TABLES: ZTT_CL_DEPE_A                  .
