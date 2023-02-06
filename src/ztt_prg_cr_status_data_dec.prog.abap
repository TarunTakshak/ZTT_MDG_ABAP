*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_CR_STATUS_DATA_DEC
*&---------------------------------------------------------------------*


*TYPES : BEGIN OF ty_cr,
*          usmd_crequest    TYPE  usmd_crequest,
*          usmd_creq_type   TYPE  usmd_crequest_type,
*          usmd_created_by  TYPE  xubname,
*          usmd_creq_status TYPE usmd_crequest_status,
*          txtmi            TYPE  usmd_txtmi,
*        END OF ty_cr.
*
*DATA : lt_cr TYPE STANDARD TABLE OF ty_cr,
*       ls_cr TYPE ty_cr.
