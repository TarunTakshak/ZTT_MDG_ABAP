*&---------------------------------------------------------------------*
*& INCLUDE ZTT_PRG_ALV_INTERACTIVE_TOP
*&---------------------------------------------------------------------*
TYPE-POOLS : slis.

TYPES : BEGIN OF ty_ekko,
          ebeln TYPE ebeln,            "purchasing document number
          bukrs TYPE bukrs,            "company code
          bstyp TYPE ebstyp,           "purchasing document category
          bsart TYPE esart,            "purchasing document type
        END OF ty_ekko,
        BEGIN OF ty_ekpo,
          ebeln TYPE ebeln,            "purchasing document number
          loekz TYPE eloek,            "deletion indicator in purchasing document
          statu TYPE astat,            "origin of a purchasing document item
          aedat TYPE paedt,            "purchasing document item change date
        END OF ty_ekpo.

DATA :
*internaltable and workarea decalrtion for purchasing document header details
       lt_ekko   TYPE TABLE OF ty_ekko,
       ls_ekko   TYPE ty_ekko,
*internaltable and workarea decalrtion for purchasing document item details
       lt_ekpo   TYPE TABLE OF ty_ekpo,
       ls_ekpo   TYPE ty_ekpo,
*local variable for purchasing document number
       lv_ebeln  TYPE ekko-ebeln,
*internaltable and workarea decalrtion for fieldcatlog
       lt_fcat   TYPE slis_t_fieldcat_alv,
       ls_fcat   TYPE slis_fieldcat_alv,
*internaltable and workarea decalrtion for desiging header
       lt_header TYPE slis_t_listheader,
       ls_header TYPE slis_listheader.

"desiging selction screen
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.
  SELECT-OPTIONS : s_ebeln FOR lv_ebeln.
SELECTION-SCREEN END OF BLOCK b1.
