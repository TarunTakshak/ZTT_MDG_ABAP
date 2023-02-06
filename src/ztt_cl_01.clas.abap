class ZTT_CL_01 definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces ZTT_IF_BADI_01 .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_01 IMPLEMENTATION.


  METHOD ztt_if_badi_01~get_data.


    SELECT * FROM usmd110c INTO TABLE @DATA(lt_usmd) WHERE usmd_creq_type = @iv_cr_type.

    IF sy-subrc <> 0 AND lt_usmd IS INITIAL.
      MESSAGE 'DATA NOT FOUND' TYPE 'E'.
    ELSE.
      MESSAGE 'DATA FOUND' TYPE 'I'.
    ENDIF.
CL_DEMO_OUTPUT=>display( lt_usmd ).
  ENDMETHOD.
ENDCLASS.
