*&---------------------------------------------------------------------*
*& Include          ZTT_CUST_MODIFY_MAIN
*&---------------------------------------------------------------------*


**********************************************************************
*Read operation
**********************************************************************
  IF rb_read EQ abap_true.
    SELECT * FROM ztt_cust_mas INTO TABLE @DATA(lt_temp) WHERE cust_id = @p_r_cuid.
    IF sy-subrc EQ 0 AND lt_temp IS NOT INITIAL.
      MESSAGE i001(ztt_msg_rerfernce).
      cl_demo_output=>display( lt_temp ).
    ELSE.
      MESSAGE w000(ztt_msg_rerfernce).
    ENDIF.



**********************************************************************
*create operation
**********************************************************************



  ELSEIF rb_crt EQ abap_true.

    SELECT cust_id FROM ztt_cust_mas INTO TABLE @lt_temp WHERE cust_id EQ @p_u_cuid.

    IF lt_temp IS INITIAL.


      PERFORM mail_validate.


      lt_cont = VALUE #( ( element = 'lv_CUST_ID' value = p_c_cuid )
                       ( element = 'LV_first' value = p_c_fnam )
                       ( element = 'LV_last' value = p_c_lnam )
                       ( element = 'LV_EMAIL' value = p_c_emai )
                       ( element = 'LV_MOBILE' value = p_c_mobi )
                       ( element = 'Operations' value = 'Create' )
                       ).

      MESSAGE i003(ztt_msg_rerfernce).
    ELSE.
      MESSAGE w004(ztt_msg_rerfernce).
    ENDIF.


**********************************************************************
*update operation
**********************************************************************

  ELSEIF rb_upd EQ abap_true.

    SELECT cust_id FROM ztt_cust_mas INTO TABLE @lt_temp WHERE cust_id EQ @p_u_cuid.

    IF lt_temp IS NOT INITIAL.

      PERFORM mail_validate.
      lt_cont = VALUE #( ( element = 'lv_CUST_ID' value = p_u_cuid )
                     ( element = 'LV_first' value = p_u_fnam )
                     ( element = 'LV_last' value = p_u_lnam )
                     ( element = 'LV_EMAIL' value = p_u_emai )
                     ( element = 'LV_MOBILE' value = p_u_mobi )
                     ( element = 'Operations' value = 'Update' )
                     ).

      MESSAGE i005(ztt_msg_rerfernce).
    ELSE.
      MESSAGE w006(ztt_msg_rerfernce).
    ENDIF.


**********************************************************************
*delete operation
**********************************************************************

  ELSEIF rb_dlt EQ abap_true.

    SELECT cust_id FROM ztt_cust_mas INTO TABLE @lt_temp WHERE cust_id EQ @p_d_cuid.


    IF lt_temp IS NOT INITIAL.

      lt_cont = VALUE #( ( element = 'lv_CUST_ID' value = p_d_cuid )
                         ( element = 'Operations' value = 'Delete' )
                     ).

      MESSAGE i007(ztt_msg_rerfernce).

    ELSE.
      MESSAGE w008(ztt_msg_rerfernce).
    ENDIF.

  ENDIF.

**********************************************************************\
*F.M for starting wf
**********************************************************************

  CALL FUNCTION 'SAP_WAPI_START_WORKFLOW'
    EXPORTING
      task            = 'WS90100257'
      do_commit       = 'X'
    IMPORTING
      return_code     = lv_rcode
      workitem_id     = lv_wid
    TABLES
      input_container = lt_cont.


  IF lv_rcode IS  INITIAL.
    WRITE : 'Workitem-ID = ',lv_wid.
  ENDIF.






*&---------------------------------------------------------------------*
*& Form mail_validate
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM mail_validate .


    CREATE OBJECT go_regex
      EXPORTING
        pattern     = '\w+(\.\w+)*@(\w+\.)+(\w{2,4})'
        ignore_case = abap_true.

    go_matcher = go_regex->create_matcher( text = p_c_emai ).

    IF go_matcher->match( ) IS INITIAL.

      MESSAGE w009(ztt_msg_rerfernce).
    ENDIF.

*    if p_c_mobi cp '^[1-9]\d{2}-[1-9]\d{2}-\d{4}$ '.
*      MESSAGE 'correct' type 'I'.
*  else.
*    MESSAGE 'incorrect' TYPE 'E'.
*  endif.
  ENDFORM.
