*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_DATA_R_TOP
*&---------------------------------------------------------------------*

type-POOLs : slis.

TYPES : BEGIN OF ty_tab,
          "TABLE NAME
          tabname   TYPE dd03l-tabname,
          "FIELD NAME
          fieldname TYPE dd03l-fieldname,
          "DATE ELEMENT
          rollname  TYPE dd03l-rollname,
          "VALUE TABLE
          entitytab TYPE dd01l-entitytab,
        END OF ty_tab.

DATA :
"internal table & workarea to hold ty_tab strcuture
       lt_tab  TYPE TABLE OF ty_tab,
       ls_tab  like LINE OF lt_tab,
"internal table & workarea FOR field-catlog
       lt_fcat TYPE slis_t_fieldcat_alv.
       "ls_fcat TYPE slis_fieldcat_alv.
