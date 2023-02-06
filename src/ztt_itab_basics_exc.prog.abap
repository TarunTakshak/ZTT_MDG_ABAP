*&---------------------------------------------------------------------*
*& Report ZTT_ITAB_BASICS_EXC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTT_ITAB_BASICS_EXC.


TYPES group TYPE c LENGTH 1.
TYPES: BEGIN OF initial_type,
         group       TYPE group,
         number      TYPE i,
         description TYPE string,
       END OF initial_type.

data : initial_data TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.


data : updated_data like initial_data,
       sort_data like initial_data,
       result type i.


data(lo_obj) = new ztt_cl_itab_basics( ).

call method lo_obj->fill_itab
  RECEIVING
    initial_data = initial_data
  .

cl_demo_output=>display_data(
  EXPORTING
    value   =  initial_data
    ).


call METHOD lo_obj->add_to_itab
  EXPORTING
    initial_data = initial_data
  RECEIVING
    updated_data = updated_data
  .



  cl_demo_output=>display_data(
    EXPORTING
      value   = updated_data

  ).

  call METHOD lo_obj->sort_itab
    EXPORTING
      initial_data = initial_data
    RECEIVING
     updated_data = sort_data
    .

  cl_demo_output=>display_data(
    EXPORTING
      value   = sort_data

  ).

  call METHOD lo_obj->search_itab
    EXPORTING
      initial_data = initial_data
    RECEIVING
      result_index = result
    .


  cl_demo_output=>display_data(
    EXPORTING
      value   = result

  ).
