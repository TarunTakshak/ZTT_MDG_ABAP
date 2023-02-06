class ZTT_CL_WF_CALL_TRANSC definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  class-methods CALL_VA01
    importing
      !IV_VBELN type VBAK-VBELN .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_WF_CALL_TRANSC IMPLEMENTATION.


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


  METHOD call_va01.



    IF  iv_vbeln IS NOT INITIAL .
      SET PARAMETER ID 'AUN' FIELD iv_vbeln.
      CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.


    ENDIF.


  ENDMETHOD.
ENDCLASS.
