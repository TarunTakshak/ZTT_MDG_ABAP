*&---------------------------------------------------------------------*
*& INCLUDE ZTT_PRG_REFERNCE_DATA_TOP
*&---------------------------------------------------------------------*
TYPE-POOLS : slis.
TYPES : BEGIN OF ty_tab,
          tabname   TYPE dd03l-tabname,
                                       "TABLE NAME
          fieldname TYPE dd03l-fieldname,
                                       "FIELD NAME
          rollname  TYPE dd03l-rollname,
                                       "DATE ELEMENT
          entitytab TYPE dd01l-entitytab,
                                       "VALUE TABLE
          domname   TYPE dd01l-domname,
                                       "DOMAIN NAME
        END OF ty_tab.

DATA :
"internal table and workarea declartion to hold structure
       lt_tab  TYPE TABLE OF ty_tab,
       ls_tab  TYPE ty_tab,
"internal table and workarea declartion for field-catlog
       lt_fcat TYPE slis_t_fieldcat_alv,
       ls_fcat TYPE slis_fieldcat_alv.

FIELD-SYMBOLS <fs_mod> TYPE ty_tab.

"screen designing
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
  SELECTION-SCREEN COMMENT 2(20) cm1.
  PARAMETERS : pv_tab  RADIOBUTTON GROUP rb1 USER-COMMAND uc1 DEFAULT 'X',
               pv_str  RADIOBUTTON GROUP rb1,
               pv_de   RADIOBUTTON GROUP rb1,
               pv_dm   RADIOBUTTON GROUP rb1,
               pv_fild RADIOBUTTON GROUP rb1.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.
  PARAMETERS : pv_table TYPE tabname MODIF ID mo1,
                                       "table name
               pv_field TYPE char20 MODIF ID mo2.
SELECTION-SCREEN END OF BLOCK b2.
