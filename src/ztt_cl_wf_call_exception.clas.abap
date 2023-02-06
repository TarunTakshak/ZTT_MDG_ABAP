class ZTT_CL_WF_CALL_EXCEPTION definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  class-data LS_VBELN type VBAK .

  class-methods RV_VBELN
    importing
      !IV_VBELN type VBAK-VBELN
    returning
      value(R_VBELN) type VBAK-VBELN .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_WF_CALL_EXCEPTION IMPLEMENTATION.


  method BI_OBJECT~DEFAULT_ATTRIBUTE_VALUE.
  endmethod.


  method BI_OBJECT~EXECUTE_DEFAULT_METHOD.
  endmethod.


  method BI_OBJECT~RELEASE.
  endmethod.


  method BI_PERSISTENT~FIND_BY_LPOR.
  endmethod.


  method BI_PERSISTENT~LPOR.
  endmethod.


  method BI_PERSISTENT~REFRESH.
  endmethod.


  METHOD rv_vbeln.

    IF iv_vbeln is NOT INITIAL.
      SELECT SINGLE * FROM vbak INTO ls_vbeln WHERE vbeln = iv_vbeln.
      IF sy-subrc = 0.
        r_vbeln = ls_vbeln-vbeln.

      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
