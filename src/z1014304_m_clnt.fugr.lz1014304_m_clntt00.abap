*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: Z1014304_M_CLNT.................................*
TABLES: Z1014304_M_CLNT, *Z1014304_M_CLNT. "view work areas
CONTROLS: TCTRL_Z1014304_M_CLNT
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_Z1014304_M_CLNT. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_Z1014304_M_CLNT.
* Table for entries selected to show on screen
DATA: BEGIN OF Z1014304_M_CLNT_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE Z1014304_M_CLNT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF Z1014304_M_CLNT_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF Z1014304_M_CLNT_TOTAL OCCURS 0010.
INCLUDE STRUCTURE Z1014304_M_CLNT.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF Z1014304_M_CLNT_TOTAL.

*.........table declarations:.................................*
TABLES: Z1014304_T_CLNT                .
