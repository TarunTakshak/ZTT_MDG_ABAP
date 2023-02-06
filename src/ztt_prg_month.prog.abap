*&---------------------------------------------------------------------*
*& Report ZTT_PRG_MONTH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_month.


PARAMETERS : p_month TYPE numc2,
             p_year  TYPE numc4.


DATA : lv_first_d TYPE datum,
       lv_last_d  TYPE datum,
       lv_date    TYPE datum,
       lv_weekday TYPE hrvsched-daytxt,
       lv_temp    TYPE datum.


CONCATENATE p_year p_month '01' INTO lv_first_d.


CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'
  EXPORTING
    day_in            = lv_first_d
  IMPORTING
    last_day_of_month = lv_last_d.

lv_temp = lv_last_d.

CALL FUNCTION 'RH_GET_DATE_DAYNAME'
  EXPORTING
    langu  = 'E'
    date   = lv_temp
  IMPORTING
    daytxt = lv_weekday.


WRITE : 'Day--',lv_weekday,'DATE--',lv_last_d.
