*&---------------------------------------------------------------------*
*& Include          ZTT_MAINTAIN_CUSTOMER_TOP
*&---------------------------------------------------------------------*


TABLES : ztt_cust_mas.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.


  PARAMETERS :
    "radio-button for create customer
    rb_crt   RADIOBUTTON GROUP rb1 USER-COMMAND uc1,
    p_c_cuid TYPE  ztt_cust_mas-cust_id MODIF ID mo1,           "customer-id
    p_c_fnam TYPE  ztt_de_first_name MODIF ID mo1,        "first-name
    p_c_lnam TYPE  ztt_de_last_name MODIF ID mo1,         "last-name
    p_c_emai TYPE  mailaddress MODIF ID mo1,             "email
    p_c_mobi TYPE  ztt_de_mobile MODIF ID mo1,            "mobile
    "radio-button for update customer
    rb_upd   RADIOBUTTON GROUP rb1,
    p_u_cuid TYPE ztt_de_cust_id MODIF ID mo2,            "customer-id
    p_u_fnam TYPE  ztt_de_first_name MODIF ID mo2,         "first-name
    p_u_lnam TYPE  ztt_de_last_name MODIF ID mo2,          "last-name
    p_u_emai TYPE  mailaddress MODIF ID mo2,              "email
    p_u_mobi TYPE  ztt_de_mobile MODIF ID mo2,             "mobile
    "radio-button for delete customer
    rb_dlt   RADIOBUTTON GROUP rb1,
    p_d_cuid TYPE  ztt_de_cust_id MODIF ID mo3 ,            "customer-id
    "radio-button for read customer
    rb_read  RADIOBUTTON GROUP rb1,
    p_r_cuid TYPE  ztt_de_cust_id MODIF ID mo4,            "customer-id

    rb_none  RADIOBUTTON GROUP rb1 DEFAULT 'X'.


SELECTION-SCREEN END OF BLOCK b1.


DATA :
*local variable for retrun-code
  lv_rcode TYPE sysubrc,
*local variable for workitem-id
  lv_wid   TYPE sww_wiid,
*internal table for container
  lt_cont  TYPE TABLE OF swr_cont.

"data declartion for mail validation
DATA: go_regex   TYPE REF TO cl_abap_regex,
      go_matcher TYPE REF TO cl_abap_matcher,
      go_match   TYPE c LENGTH 1,
      gv_msg     TYPE string.
