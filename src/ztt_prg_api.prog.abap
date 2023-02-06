*&---------------------------------------------------------------------*
*& Report ZTT_PRG_API
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_api.

*types : BEGIN OF ty_ex,
*        data type any

DATA : lo_crequest TYPE REF TO if_usmd_crequest_api,
       lv_cr       TYPE usmd_crequest,
       lt_messages TYPE usmd_t_message.





CALL METHOD cl_usmd_crequest_api=>get_instance
  IMPORTING
    re_inst_crequest_api = lo_crequest.           " Change Request API Interface


CALL METHOD lo_crequest->enqueue_crequest
  EXPORTING
    iv_lock_type = 'E'              " Lock mode
  IMPORTING
    et_message   = lt_messages.               " Log Interface Messages

CALL METHOD lo_crequest->create_crequest
  EXPORTING
    iv_crequest_type = 'ZTT_CUST'
    iv_crequest_text = 'SAMPLE'
  IMPORTING
    ev_crequest_id   = DATA(lv_cid)              " Natural number
    et_message       = lt_messages.                         " Messages




FIELD-SYMBOLS : <fs_data> TYPE ANY TABLE.


data lr_ref TYPE REF TO data.



"get REFERENCE OF lv_temp INTO lr_ref.


DATA(lv_temp) = 'SAMPLE CR'.
"CREATE DATA lr_ref LIKE STANDARD TABLE OF <fs_data>.
"assign lr_ref->* to <fs_data>.
ASSIGN COMPONENT  'LV_TEMP' OF STRUCTURE <fs_data> to FIELD-SYMBOL(<fs_field>).





   "   APPEND <fs_str> to <fs_data>.



CALL METHOD lo_crequest->write_value
  EXPORTING
    i_fieldname = ''                      " Field Name
    it_data     = <fs_data>
  IMPORTING
    et_message  = lt_messages.                               " Messages
