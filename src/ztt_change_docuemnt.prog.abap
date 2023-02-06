*&---------------------------------------------------------------------*
*& Report ZTT_CHANGE_DOCUEMNT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTT_CHANGE_DOCUEMNT.

data : wa_new TYPE Z1014304_T_MENU,
       wa_old TYPE Z1014304_T_MENU,
       it_cdtxt TYPE TABLE of cdtxt.


 wa_new-MENU_ID = '123'.
 wa_new-HOTEL_ID = 'hotel01'.
 wa_new-MENU_NAME = 'snacks'.
 wa_new-MENU_TYPE = 'veg'.
 wa_new-PRICE = '1000'.
 wa_new-DESCRIPTION = 'abcd'.

 INSERT Z1014304_T_MENU FROM wa_new.

 CALL FUNCTION 'Z4304_CHANGE_WRITE_DOCUMENT'
   EXPORTING
     objectid                      = 'Z4304_CHANGE'
     tcode                         = sy-tcode
     utime                         = sy-uzeit
     udate                         = sy-datum
     username                      = sy-uname
*    PLANNED_CHANGE_NUMBER         = ' '
*    OBJECT_CHANGE_INDICATOR       = 'U'
*    PLANNED_OR_REAL_CHANGES       = ' '
*    NO_CHANGE_POINTERS            = ' '
*    UPD_ICDTXT_Z4304_CHANGE       = ' '
    N_Z1014304_T_MENU             = wa_new
    O_Z1014304_T_MENU             = wa_old
    UPD_Z1014304_T_MENU           = 'I'
  TABLES
    ICDTXT_Z4304_CHANGE           = it_cdtxt
           .
