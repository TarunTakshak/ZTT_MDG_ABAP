class ZTT_CL_WF_CRUD definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  class-data LT_CUST type ZTT_TT_CUST_MAS .

  class-methods CREATE_CUSTOMER
    importing
      !IV_CUST_ID type ZTT_DE_CUST_ID
      !IV_FIRST_NAME type ZTT_DE_FIRST_NAME
      !IV_LAST_NAME type ZTT_DE_LAST_NAME
      !IV_EMAIL type MAILADDRESS
      !IV_MOBILE type ZTT_DE_MOBILE .
  class-methods DELETE__CUSTOMER
    importing
      value(IV_CUST_ID) type ZTT_DE_CUST_ID .
  class-methods UPDATE_CUSTOMER
    importing
      !IV_CUST_ID type ZTT_DE_CUST_ID
      !IV_FIRST_NAME type ZTT_DE_FIRST_NAME
      !IV_LAST_NAME type ZTT_DE_LAST_NAME
      !IV_EMAIL type MAILADDRESS
      !IV_MOBILE type ZTT_DE_MOBILE .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_WF_CRUD IMPLEMENTATION.


  METHOD create_customer.



    APPEND VALUE #( cust_id =  iv_cust_id
                    first_name = iv_first_name
                    last_name = iv_last_name
                    email = iv_email
                    mobile = iv_mobile ) TO lt_cust.

    INSERT ZTT_CUST_MAS from TABLE lt_cust.

    IF sy-subrc = 0 AND lt_cust IS NOT INITIAL.
      MESSAGE 'VALUES INSERTES SUCESSFULLY' TYPE 'I'.
    ELSE.
      MESSAGE 'VALUES NOT INSERTED' TYPE 'E'.

    ENDIF.

  ENDMETHOD.


  method DELETE__CUSTOMER.

    DELETE FROM ztt_cust_mas  where CUST_ID = iv_cust_id.

  endmethod.


  METHOD update_customer.



    UPDATE ztt_cust_mas SET cust_id = iv_cust_id
                            first_name = iv_first_name
                            last_name = iv_last_name
                            email = iv_email
                            mobile = iv_mobile
                            where cust_id = iv_cust_id.




  ENDMETHOD.
ENDCLASS.
