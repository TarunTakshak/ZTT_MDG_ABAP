class ZTT_CL_WF_LEAVE_REQUEST definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  class-methods LV_MANAGER
    importing
      !LV_EMP_ID type PERNR_D
    returning
      value(LV_MANAGER) type CHAR25 .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_WF_LEAVE_REQUEST IMPLEMENTATION.


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


  METHOD lv_manager.


    DATA : ls_emp_mgn TYPE zwf_manager,
           lv_temp    TYPE wdy_boolean.

    IF lv_emp_id IS NOT INITIAL.
      SELECT SINGLE * FROM zwf_manager INTO ls_emp_mgn ."WHERE empid = '01011501'.
      IF sy-subrc EQ 0.
        lv_manager = ls_emp_mgn-manager.

      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
