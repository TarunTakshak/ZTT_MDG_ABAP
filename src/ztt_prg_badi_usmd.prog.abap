*&---------------------------------------------------------------------*
*& Report ZTT_PRG_BADI_USMD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTT_PRG_BADI_USMD.

**********************************************************************
*(1) - Fetching data from usmd110c
**********************************************************************

*PARAMETERS : p_cr_ty TYPE USMD_CREQUEST_TYPE.
*
*data : lo_temp TYPE REF TO ZTT_BADI_DEF_01.
*
*GET BADI lo_temp.
*
*call badi lo_temp->get_data
*  EXPORTING
*    iv_cr_type = p_cr_ty.                 " Type of Change Request



**********************************************************************
*(2) - moving data from one it to other it
**********************************************************************

PARAMETERS : P_CR_TY TYPE USMD_CREQUEST_TYPE.

DATA : lo_temp TYPE REF TO ZTT_BADI_DEF_02,
       lt_temp TYPE TABLE of ZTT_INC_USMD110C.

GET BADI lo_temp.

call BADI lo_temp->move_data
  EXPORTING
    iv_cr_type =  p_cr_ty                " Type of Change Request
  CHANGING
    et_usmd    =  lt_temp                 " Type of Change Request
  .

    cl_demo_output=>display( lt_temp ).
