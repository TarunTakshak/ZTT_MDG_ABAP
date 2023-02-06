class ZCL_Z4304_CHNAGE_ME_CHDO definition
  public
  create public .

public section.

  interfaces IF_CHDO_ENHANCEMENTS .

  class-data OBJECTCLASS type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDOBJECTCL read-only value 'Z4304_CHNAGE_ME' ##NO_TEXT.

  class-methods WRITE
    importing
      !OBJECTID type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDOBJECTV
      !TCODE type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDTCODE
      !UTIME type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDUZEIT
      !UDATE type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDDATUM
      !USERNAME type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDUSERNAME
      !PLANNED_CHANGE_NUMBER type IF_CHDO_OBJECT_TOOLS_REL=>TY_PLANCHNGNR default SPACE
      !OBJECT_CHANGE_INDICATOR type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH default 'U'
      !PLANNED_OR_REAL_CHANGES type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDFLAG default SPACE
      !NO_CHANGE_POINTERS type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDFLAG default SPACE
      !O_Z1014304_T_MENU type Z1014304_T_MENU optional
      !N_Z1014304_T_MENU type Z1014304_T_MENU optional
      !UPD_Z1014304_T_MENU type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH default SPACE
    exporting
      value(CHANGENUMBER) type IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHANGENR
    raising
      CX_CHDO_WRITE_ERROR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_Z4304_CHNAGE_ME_CHDO IMPLEMENTATION.


  method WRITE.
*"----------------------------------------------------------------------
*"         this WRITE method is generated for object Z4304_CHNAGE_ME
*"         never change it manually, please!        :20.07.2022
*"         All changes will be overwritten without a warning!
*"
*"         CX_CHDO_WRITE_ERROR is used for error handling
*"----------------------------------------------------------------------

    DATA: l_upd        TYPE if_chdo_object_tools_rel=>ty_cdchngind.

    CALL METHOD cl_chdo_write_tools=>changedocument_open
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        planned_change_number   = planned_change_number
        planned_or_real_changes = planned_or_real_changes.

     IF ( N_Z1014304_T_MENU IS INITIAL ) AND
        ( O_Z1014304_T_MENU IS INITIAL ).
       l_upd  = space.
     ELSE.
       l_upd = UPD_Z1014304_T_MENU.
     ENDIF.

     IF  l_upd  NE space.
       CALL METHOD CL_CHDO_WRITE_TOOLS=>changedocument_single_case
         EXPORTING
           tablename              = 'Z1014304_T_MENU'
           workarea_old           = O_Z1014304_T_MENU
           workarea_new           = N_Z1014304_T_MENU
           change_indicator       = UPD_Z1014304_T_MENU
           docu_delete            = ''
           docu_insert            = ''
           docu_delete_if         = ''
           docu_insert_if         = ''
                  .
     ENDIF.

    CALL METHOD cl_chdo_write_tools=>changedocument_close
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        date_of_change          = udate
        time_of_change          = utime
        tcode                   = tcode
        username                = username
        object_change_indicator = object_change_indicator
        no_change_pointers      = no_change_pointers
      IMPORTING
        changenumber            = changenumber.


*"  Code snippets to be used with COPY+PASTE
*"  uncomment the needed parts
*"  change names if needed

*"  Start of default parameter part
* DATA: objectid                TYPE cdhdr-objectid,
*       tcode                   TYPE cdhdr-tcode,
*       planned_change_number   TYPE cdhdr-planchngnr,
*       utime                   TYPE cdhdr-utime,
*       udate                   TYPE cdhdr-udate,
*       username                TYPE cdhdr-username,
*       cdoc_planned_or_real    TYPE cdhdr-change_ind,
*       cdoc_upd_object         TYPE cdhdr-change_ind VALUE 'U',
*       cdoc_no_change_pointers TYPE cdhdr-change_ind.
* DATA: cdchangenumber          TYPE cdhdr-changenr.
*"  End of default parameter part

*" Begin of dynamic DATA part for class ZCL_Z4304_CHNAGE_ME_CHDO
*"   workaera_old of Z1014304_T_MENU
* DATA OS_Z1014304_T_MENU TYPE Z1014304_T_MENU.
*"   workaera_new of Z1014304_T_MENU
* DATA NS_Z1014304_T_MENU TYPE Z1014304_T_MENU.
*"   change indicator for Z1014304_T_MENU
* DATA UPD_Z1014304_T_MENU TYPE IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH.

*"     Change Number of Document
* DATA CHANGENUMBER TYPE IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHANGENR.
*"   workaera_old of Z1014304_T_MENU
* DATA OS_Z1014304_T_MENU TYPE Z1014304_T_MENU.
*"   workaera_new of Z1014304_T_MENU
* DATA NS_Z1014304_T_MENU TYPE Z1014304_T_MENU.
*"   change indicator for Z1014304_T_MENU
* DATA UPD_Z1014304_T_MENU TYPE IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHNGINDH.

*"     Change Number of Document
* DATA CHANGENUMBER TYPE IF_CHDO_OBJECT_TOOLS_REL=>TY_CDCHANGENR.

*" End of dynamic DATA part for class ZCL_Z4304_CHNAGE_ME_CHDO


*"  Begin of method call part
*"  define needed DATA for error handling
* DATA err_ref TYPE REF TO cx_chdo_write_error.
* DATA err_action TYPE string.

*    TRY.
*        CALL METHOD ZCL_Z4304_CHNAGE_ME_CHDO=>write
*          EXPORTING
*            objectid                = objectid
*            tcode                   = tcode
*            utime                   = utime
*            udate                   = udate
*            username                = username
*            planned_change_number   = planned_change_number
*            object_change_indicator = cdoc_upd_object
*            planned_or_real_changes = cdoc_planned_or_real
*            no_change_pointers      = cdoc_no_change_pointers
*"  End of default method call part

*" Begin of dynamic part for method call
*"   workaera_old of Z1014304_T_MENU
*   O_Z1014304_T_MENU = OS_Z1014304_T_MENU
*"   workaera_new of Z1014304_T_MENU
*   N_Z1014304_T_MENU = NS_Z1014304_T_MENU
*"   change indicator for Z1014304_T_MENU
*   UPD_Z1014304_T_MENU = UPD_Z1014304_T_MENU

*"     Change Number of Document
*"   workaera_old of Z1014304_T_MENU
*   O_Z1014304_T_MENU = OS_Z1014304_T_MENU
*"   workaera_new of Z1014304_T_MENU
*   N_Z1014304_T_MENU = NS_Z1014304_T_MENU
*"   change indicator for Z1014304_T_MENU
*   UPD_Z1014304_T_MENU = UPD_Z1014304_T_MENU

*"     Change Number of Document
*           IMPORTING
*             changenumber            = cdchangenumber.
*      CATCH cx_chdo_write_error INTO err_ref.
*"        MESSAGE err_ref TYPE 'A'.
*"   error information could be determined with default GET_TEXT, GET_LONGTEXT, GET_SOURCE_POSITION methds

*    ENDTRY.
*" End of dynamic part for method call
  endmethod.
ENDCLASS.
