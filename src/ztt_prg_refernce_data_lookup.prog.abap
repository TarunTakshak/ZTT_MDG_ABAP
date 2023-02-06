*&---------------------------------------------------------------------*
*& REPORT ZTT_PRG_REFERNCE_DATA_LOOKUP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_refernce_data_lookup.


INCLUDE ztt_prg_refernce_data_top.     "include to hold data decalrtions

INCLUDE ztt_prg_refernce_data_main.    "include to hold main logic
*"--------------------------------------------------------------------*
* AT SELECTION-SCREEN EVENT *
*"--------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.
  PERFORM dis_output.
*"--------------------------------------------------------------------*
* START OF SELECTION EVENT *
*"--------------------------------------------------------------------*
START-OF-SELECTION.
  IF pv_tab EQ abap_true.
    PERFORM get_table.                 "perform to hold table details
    PERFORM field_cat.                 "perform to hold field-catlog for table details
    PERFORM tab_dis.                   "perform to diplay table details


  ELSEIF pv_str EQ abap_true.
    PERFORM get_str.                   "perform to hold strucutre details
    PERFORM field_cat_str.             "perform to hold field-catlog for strucutre details
    PERFORM str_dis.                   "perform to diplay strucutre details


  ELSEIF pv_de EQ abap_true.
    PERFORM get_de.                    "perform to hold dataelement details
    PERFORM field_cat_de.              "perform to hold field-catlog for dataelement details
    PERFORM de_dis.                    "perform to diplay dataelement details


  ELSEIF pv_dm EQ abap_true.
    PERFORM get_domain.                "perform to hold domain details
    PERFORM field_cat_dom.             "perform to hold field-catlog for domain details
    PERFORM dom_dis.                   "perform to diplay domain details


  ELSEIF pv_fild EQ abap_true.
    PERFORM get_field.                 "perform to hold field details
    PERFORM field_cat_fld.             "perform to hold field-catlog for field details
    PERFORM fld_dis.                   "perform to diplay field details



  ENDIF.                               "IF pv_tab EQ abap_true.







*"--------------------------------------------------------------------*
* END OF SELECTION EVENT *
*"--------------------------------------------------------------------*
*END-OF-SELECTION.
  " PERFORM tab_dis.                     "perform to diplay table details
  "PERFORM str_dis.                     "perform to diplay strucutre details
  " PERFORM de_dis.                      "perform to diplay dataelement details
  "PERFORM dom_dis.                     "perform to diplay domain details
  "  PERFORM fld_dis.                     "perform to diplay field details
