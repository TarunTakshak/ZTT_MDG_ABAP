*&---------------------------------------------------------------------*
*& Report ZTT_PRG_ALL_OCC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTT_PRG_ALL_OCC.


PARAMETERS : p_string type string,
             P_sub TYPE char5.

data : lv_temp type i.

FIND ALL OCCURRENCES OF p_sub in p_string MATCH COUNT lv_temp.

write : p_string,'------',p_sub,'-----',lv_temp.
