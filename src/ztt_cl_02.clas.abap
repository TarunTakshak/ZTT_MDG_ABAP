class ZTT_CL_02 definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces ZTT_IF_BADI_02 .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_02 IMPLEMENTATION.


  METHOD ztt_if_badi_02~move_data.

    TYPES : BEGIN OF ty_usmd,
              usmd_creq_type   TYPE	usmd_crequest_type,
              usmd_entity_main TYPE usmd_entity_main,
              usmd_crequest_wf TYPE USMD_WORKFLOW,

            END OF ty_usmd.

    DATA : lt_usmd TYPE TABLE OF ty_usmd.

    SELECT  usmd_creq_type
            usmd_entity_main
              usmd_crequest_wf
                       FROM usmd110c INTO TABLE lt_usmd WHERE usmd_creq_type = iv_cr_type.

    IF sy-subrc <> 0 AND lt_usmd IS INITIAL.

      MESSAGE 'DATA NOT FOUNd' TYPE 'E'.

    ELSE.

      et_usmd = VALUE #( FOR ls_usmd IN lt_usmd ( usmd_creq_type = ls_usmd-usmd_creq_type )
                                                ( usmd_entity_main = ls_usmd-usmd_entity_main )
                                                ( usmd_crequest_wf = ls_usmd-usmd_crequest_wf )
                                                ).



    ENDIF.


  ENDMETHOD.
ENDCLASS.
