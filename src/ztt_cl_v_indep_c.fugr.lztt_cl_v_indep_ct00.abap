*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTT_CL_V_INDEP_C................................*
TABLES: ZTT_CL_V_INDEP_C, *ZTT_CL_V_INDEP_C. "view work areas
CONTROLS: TCTRL_ZTT_CL_V_INDEP_C
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZTT_CL_V_INDEP_C. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZTT_CL_V_INDEP_C.
* Table for entries selected to show on screen
DATA: BEGIN OF ZTT_CL_V_INDEP_C_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZTT_CL_V_INDEP_C.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZTT_CL_V_INDEP_C_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZTT_CL_V_INDEP_C_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZTT_CL_V_INDEP_C.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZTT_CL_V_INDEP_C_TOTAL.

*.........table declarations:.................................*
TABLES: ZTT_CL_INDEPE_C                .
