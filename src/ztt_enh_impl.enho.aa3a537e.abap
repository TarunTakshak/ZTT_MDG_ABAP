"Name: \TY:CL_ABAPWD_FLIGHT_MODEL\ME:GET_CUSTOMER_DATA\SE:END\EI
ENHANCEMENT 0 ZTT_ENH_IMPL.
 DATA lt_cus type TABLE OF scustom.
 APPEND VALUE #( id = '1001' name = 'TARUN' ) to lt_cus .
ENDENHANCEMENT.
