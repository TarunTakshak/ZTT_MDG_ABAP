*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_SEARCH_HELP
*&---------------------------------------------------------------------*


*--------------------------------------------------------------*
*Selection-Screen on Value-Request
*--------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_crtype.

  REFRESH gt_dynpfields.
  REFRESH : gt_return,gt_dynpfields.
  CLEAR : gv_user,gwa_return.

  gwa_dynpfields-fieldname = 'P_USERNA'.
  APPEND gwa_dynpfields TO gt_dynpfields.
  CLEAR gwa_dynpfields.

  CALL FUNCTION 'DYNP_VALUES_READ'
    EXPORTING
      dyname               = sy-repid
      dynumb               = sy-dynnr
      translate_to_upper   = abap_true
    TABLES
      dynpfields           = gt_dynpfields
    EXCEPTIONS
      invalid_abapworkarea = 1
      invalid_dynprofield  = 2
      invalid_dynproname   = 3
      invalid_dynpronummer = 4
      invalid_request      = 5
      no_fielddescription  = 6
      invalid_parameter    = 7
      undefind_error       = 8
      double_conversion    = 9
      stepl_not_found      = 10
      OTHERS               = 11.

  READ TABLE gt_dynpfields INTO gwa_dynpfields WITH KEY fieldname = 'P_USERNA'.
  IF sy-subrc = 0.
    p_userna = gwa_dynpfields-fieldvalue.
  ENDIF.

  SELECT
         usmd_creq_type
         INTO TABLE @DATA(gt_shelp)
         FROM usmd120c
         WHERE
    usmd_created_by = @p_userna.

  IF sy-subrc EQ 0.
    SORT gt_shelp BY usmd_creq_type.
    DELETE ADJACENT DUPLICATES FROM gt_shelp COMPARING usmd_creq_type.


  ENDIF.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'USMD_CREQ_TYPE'
      value_org       = 'S'
      dynprofield     = 'P_CRTYPE'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
    TABLES
      value_tab       = gt_shelp
      return_tab      = gt_return
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.

  READ TABLE gt_return INTO gwa_return INDEX 1.
  IF sy-subrc = 0.
    p_crtype = gwa_return-fieldval.

    REFRESH gt_dynpfields.
    REFRESH : gt_return,gt_dynpfields.
    CLEAR : gv_user,gwa_return.
  ENDIF.
