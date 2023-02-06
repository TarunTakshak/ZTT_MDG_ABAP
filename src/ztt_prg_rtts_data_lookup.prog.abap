*&---------------------------------------------------------------------*
*& Report ZTT_PRG_RTTS_DATA_LOOKUP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_rtts_data_lookup.



*PARAMETERS : p_table TYPE dd03l-tabname.
*
*
*DATA(component) = VALUE cl_abap_structdescr=>component_table(
*
*                  (
*                      name = 'TABNAME'
*                      type = CAST #( cl_abap_elemdescr=>describe_by_name( 'TABNAME' ) )
*                   )
*                  (
*                        name = 'FIELDNAME'
*                      type = CAST #( cl_abap_elemdescr=>describe_by_name( 'FIELDNAME' ) )
*                   )
*                  (
*                    name = 'ROLLNAME'
*                     type = CAST #( cl_abap_elemdescr=>describe_by_name( 'ROLLNAME' ) )
*                   )
*
*                  ).

data : lo_type_desc TYPE REF TO cl_abap_typedescr,
       lo_data_desc type REF TO cl_abap_datadescr,
       lo_struct_desc TYPE REF TO cl_abap_datadescr,
       lt_compt TYPE abap_component_tab,
       ls_compt TYPE abap_componentdescr.


ls_compt-name = 'TABNAME'.
ls_compt-type ?= cl_abap_typedescr=>describe_by_name( p_name = 'TABNAME').
APPEND ls_compt to lt_compt.
clear ls_compt.

ls_compt-name = 'FIELDNAME'.
ls_compt-type ?= cl_abap_typedescr=>describe_by_name( p_name = 'FIELDNAME').
APPEND ls_compt to lt_compt.
clear ls_compt.

ls_compt-name = 'ROLLNAME'.
ls_compt-type ?= cl_abap_typedescr=>describe_by_name( p_name = 'ROLLNAME').
APPEND ls_compt to lt_compt.
clear ls_compt.

ls_compt-name = 'ENTITYNAME'.
ls_compt-type ?= cl_abap_typedescr=>describe_by_name( p_name = 'ENTITYNAME').
APPEND ls_compt to lt_compt.
clear ls_compt.

lo_struct_desc = cl_abap_structdescr=>get( p_components = lt_compt ).
