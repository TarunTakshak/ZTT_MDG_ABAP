class ZTT_CL_OG definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_CREQUEST_INTEGR .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_OG IMPLEMENTATION.


  method IF_EX_USMD_CREQUEST_INTEGR~CHECK_CREQUEST_SUBMIT_FOR_NOTE.
  endmethod.


  METHOD if_ex_usmd_crequest_integr~filter_crequest_type.

    "IF sy-uname = 'TAKSHAKT'.
*
*      SELECT usmd_creq_type FROM usmd110c
*                            INTO TABLE ct_crequest_type
*                           WHERE usmd110c~usmd_creq_type LIKE 'ZTT%'.
*
        " SELECT usmd_creq_type FROM usmd110c
         "                   INTO TABLE ct_crequest_type
          "                 WHERE usmd_creq_type LIKE '%ZCUSTlP2%'. "and usmd110c~usmd_creq_type LIKE '%ZSUPlP1%'  .

  "  ENDIF.

  ENDMETHOD.


  method IF_EX_USMD_CREQUEST_INTEGR~GET_CREQUEST_ATTRIBUTES.
  endmethod.


  method IF_EX_USMD_CREQUEST_INTEGR~GET_CREQUEST_FLD_PROP.
  endmethod.
ENDCLASS.
