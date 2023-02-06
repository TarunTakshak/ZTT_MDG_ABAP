*&---------------------------------------------------------------------*
*& Include          ZTT_PRG_CR_STATUS_CLASS
*&---------------------------------------------------------------------*


CLASS lc_cr_data DEFINITION.

  PUBLIC SECTION.

    TYPES :
*structure to hold cr status
      BEGIN OF ty_cr,
        usmd_crequest    TYPE	usmd_crequest,
        usmd_creq_type   TYPE	usmd_crequest_type,
        usmd_created_by  TYPE  xubname,
        usmd_creq_status TYPE usmd_crequest_status,
        txtmi            TYPE  usmd_txtmi,
      END OF ty_cr,
*structure to hold agent
      BEGIN OF ty_wid,
        wi_agnt TYPE sww_aagent,
      END OF ty_wid,

*tempory internal table to hold data of cr status
      lt_cr_temp TYPE TABLE OF ty_cr.

    DATA :
"internal table to hold data of cr status
      lt_cr    TYPE TABLE OF ty_cr.


    METHODS : get_cr IMPORTING i_cr_type TYPE usmd_crequest_type
                     EXPORTING et_cr     TYPE lt_cr_temp.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lc_cr_data IMPLEMENTATION.
**********************************************************************
*method for fetching cr details
**********************************************************************
  METHOD get_cr.
    SELECT
           usmd120c~usmd_crequest
           usmd120c~usmd_creq_type
           usmd120c~usmd_created_by
           usmd120c~usmd_creq_status
           usmd130t~txtmi
      INTO TABLE lt_cr
      FROM usmd120c INNER JOIN usmd130t
        ON usmd120c~usmd_creq_status =  usmd130t~usmd_creq_status
     WHERE usmd120c~usmd_creq_type = p_crtype AND usmd120c~usmd_created_by = p_userna
     AND  usmd130t~langu = 'E'.

    IF sy-subrc NE 0 AND lt_cr IS INITIAL .

      MESSAGE e000(ztt_msg_rerfernce).

    ELSE.

      et_cr[] = lt_cr[].
      SORT lt_final BY usmd_crequest ASCENDING.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
