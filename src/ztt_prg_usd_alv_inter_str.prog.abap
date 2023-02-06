*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_USD_ALV_INTER_STR
*&---------------------------------------------------------------------*

type-pools : slis.

TYPES:
  "structure to hold Type of Change Request
  BEGIN OF ty_usmd110c,
    usmd_creq_type TYPE usmd110c-usmd_creq_type,          "Type of Change Request
  END OF ty_usmd110c,
  "structure to hold Type of Change Request -Text table
  BEGIN OF ty_usmd110t,
    usmd_creq_type TYPE usmd110t-usmd_creq_type,          "Type of Change Request
    txtmi          TYPE usmd110t-txtmi,                   "Description
  END OF ty_usmd110t,
  "structure to hold Change Request
  BEGIN OF ty_usmd120c,
    usmd_crequest    TYPE usmd120c-usmd_crequest,         "Change Request
    usmd_creq_type   TYPE usmd120c-usmd_creq_type,        "Type of Change Request
    usmd_creq_status TYPE usmd120c-usmd_creq_status,      "Status of Change Request
    usmd_creq_text   TYPE usmd120c-usmd_creq_text,        "Description
    usmd_created_by  TYPE usmd120c-usmd_created_by,       "User Name in User Master Record
    txtmi            TYPE usmd110t-txtmi,
  END OF ty_usmd120c,
  "final structure
  BEGIN OF ty_final,
    usmd_creq_type TYPE usmd110c-usmd_creq_type,        "Type of Change Request
    txtmi          TYPE usmd110t-txtmi,                 "Description
  END OF ty_final.

DATA :
  "internal table and workarea to hold Type of Change Request
  lt_usmd110c     TYPE TABLE OF ty_usmd110c,
  ls_usmd110c      TYPE ty_usmd110c,
  "internal table and workarea to hold Type of Change Request -Text table
  lt_t     TYPE TABLE OF ty_usmd110t,
  ls_t     TYPE ty_usmd110t,
  "internal table and workarea to hold T Change Request -Text table
  lt_c     TYPE TABLE OF ty_usmd120c,
  ls_c     TYPE ty_usmd120c,
  "internal table and workarea to hold final strcuture
  lt_final TYPE TABLE OF ty_final,
  ls_final TYPE ty_final,
  "internal table and workarea to hold fieldcatlog
  lt_fcat  TYPE slis_t_fieldcat_alv,
  ls_fcat  TYPE slis_fieldcat_alv,
  "workarea to hold layout design
  ls_layout  TYPE slis_layout_alv,
  "variable declartion of type of change request
  lv_creq_type TYPE  usmd110c-usmd_creq_type.

SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME TITLE t.
  SELECTION-SCREEN COMMENT 2(20) n.
  SELECT-OPTIONS s_req FOR lv_creq_type.
SELECTION-SCREEN END OF BLOCK b.
