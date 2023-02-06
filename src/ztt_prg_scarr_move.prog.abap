*&---------------------------------------------------------------------*
*& Report ZTT_PRG_SCARR_MOVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztt_prg_scarr_move.

**
**TYPES : BEGIN OF ty_scar,
**          carrid   TYPE  s_carr_id,
**          carrname TYPE  s_carrname,
**        END OF ty_scar.
**
**DATA : lt_scar      TYPE TABLE OF scarr,
**
**       lt_scar_temp TYPE TABLE OF ty_scar,
**       lv_tabix     TYPE sy-tabix.
**
**SELECT * FROM scarr INTO TABLE lt_scar.
**
**
**
**" if lv_tabix mod 2 ne 0.
**
**" lt_scar_temp[] = CORRESPONDING #( lt_scar[] ).
**
**lt_scar_temp = VALUE #( FOR ls_scar IN lt_scar  ( carrid = ls_scar-carrid
**                                                 carrname = ls_scar-carrname )
**                                                   ).
**
**
**"ENDIF.
**
**"lv_tabix = lv_tabix + 1.
**
**cl_demo_output=>display( lt_scar_temp ).
**
**

*
*PARAMETERS : wi_id type SWW_WIID.
*
*data : lt type TABLE of SWWUSERWI.
*
*CALL FUNCTION 'RH_SWWUSERWI_READ_FOR_WI'
*  EXPORTING
*    wi_id                          = wi_id
**   INCLUDING_NO_SEL_ENTRIES       =
*  tables
*    act_wi_of_user                 = lt
** EXCEPTIONS
**   NOTHING_FOUND                  = 1
**   OTHERS                         = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*cl_demo_output=>display( lt ).


*data : ls_user type soudnamei1,
*       ls_userdata type soudatai1.
*
*
*ls_user-sapname = 'TAKSHAKT'.
*
*
*CALL FUNCTION 'SO_USER_READ_API1'
* EXPORTING
*   USER                            = ls_user
**   PREPARE_FOR_FOLDER_ACCESS       = ' '
*  IMPORTING
*   USER_DATA                       = ls_userdata
** EXCEPTIONS
**   USER_NOT_EXIST                  = 1
**   PARAMETER_ERROR                 = 2
**   X_ERROR                         = 3
**   OTHERS                          = 4
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*WRITE : / ls_user-sapname,
*          ls_userdata-FULLNAME.


**  DATA: user_address LIKE  addr3_val.
**    CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
**      EXPORTING
**        user_name                    = 'VOLLALAS'
***       READ_DB_DIRECTLY             = ' '
**      IMPORTING
**        user_address                 = user_address
***       USER_USR03                   =
**      EXCEPTIONS
**        user_address_not_found       = 1
**        OTHERS                       = 2.
**
**    IF sy-subrc = 0.
**       write:/ user_address-name_text.
**    ENDIF.

*TYPES:
**structure to hold cr status and agent
*  BEGIN OF ty_final,
*    usmd_creq_type   TYPE  usmd_crequest_type,   "change request type
*
*  END OF ty_final.
*
* PARAMETERS : p_userna TYPE  xubname OBLIGATORY.
*  PARAMETERS : p_crtype TYPE usmd120c-usmd_creq_type.
*
*
*data : lt_fin type TABLE of ty_final,
*       ls_fin TYPE ty_final,
*
*       lt_ret TYPE TABLE of ddshretval,
*       ls_ret TYPE ddshretval,
*
*       lt_dyn type TABLE OF dynpread,
*       ls_dyn type dynpread,
*
*       gv_user type  xubname,
*
*       lt_cr type TABLE of ty_final.
*
*
*    at SELECTION-SCREEN on VALUE-REQUEST FOR p_crtype.
*      refresh lt_dyn.
*
*      ls_dyn-fieldname = 'P_USERNA'.
*      APPEND ls_dyn to lt_dyn.
*
*
*      CALL FUNCTION 'DYNP_VALUES_READ'
*        EXPORTING
*          dyname                               = sy-repid
*          dynumb                               = sy-dynnr
*
*        TABLES
*          dynpfields                           = lt_dyn
*
*                .
* read TABLE lt_dyn into ls_dyn WITH KEY fieldname = 'P_USERNA'.
*
* IF SY-SUBRC EQ 0.
*   gv_user = ls_dyn-fieldvalue.
*
* ENDIF.
*
*  SELECT
*           usmd120c~usmd_creq_type
*
*      INTO TABLE lt_cr
*      FROM usmd120c
*     WHERE usmd120c~usmd_creq_type = gv_user
*     .
*
*    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*      EXPORTING
**       DDIC_STRUCTURE         = ' '
*        retfield               = 'USMD_CREQ_TYPE'
*       VALUE_ORG              = 'S'
*      tables
*        value_tab              = lt_cr
**       FIELD_TAB              =
*       RETURN_TAB             = lt_ret
*        EXCEPTIONS
*      parameter_error = 1
*      no_values_found = 2
*      OTHERS          = 3.
*
*              .
*    IF sy-subrc eq 0.
** Implement suitable error handling here
*
*      p_crtype = ls_ret-fieldval.
*    ENDIF.
*
*
*    LOOP AT lt_cr INTO DATA(ls_cr).
*      WRITE : ls_cr-usmd_creq_type.
*      ENDLOOP.



*TYPES: BEGIN OF FINAL,
*       partner TYPE but000-partner,
*       add_number TYPE bu-addrcomm,
*       remark TYPE ad_remark2,
*       email TYPE ad_smtpadr,
*       END OF final.
*
*data: it_final type standard table of final.
*
*select bu~partner, bu~addrcomm, at~remark, a6~smtp_addr
*from but000 as bu
*inner join adrt as at on at~addrnumber = bu~addrcomm
*inner join addr6 as a6 on a6~addrnumber = at~addrnumber
*into corresponding fields of table @it_final.

*
*PARAMETERS p_num type numc3.
*
*data : lv_count type n VALUE '0',
*        lv_result TYPE i.
*
*WHile  lv_count <= p_num.
*  lv_result = lv_count + 1.
*  WRITE : lv_result.
*  lv_count = lv_count + 1.
* ENDWHILE.

*data : ct_crequest_type type table of USMD_CREQUEST_TYPE.
*
*if sy-uname = 'TAKSHAKT'.
*
* select USMD110C~USMD_CREQ_TYPE from USMD110C
*
*
*                                  INTO TABLE ct_crequest_type
*                                 where USMD110C~USMD_CREQ_TYPE like 'ZTT%'.
*
*
*cl_demo_output=>display( ct_crequest_type ).
*endif.


*WRITE 'A text in a frame'.
*ULINE.
*
*
*
*WRITE 'A text in a frame'.
*ULINE.
*SKIP.


*data : lt_tab type HASHED TABLE  OF mara with UNIQUE KEY matnr.
*
*select * from mara into TABLE lt_tab.
*
*  DESCRIBE TABLE lt_tab LINES DATA(lines).
*
*  DESCRIBE TABLE lt_tab KIND DATA(kindd).
*
*  DESCRIBE TABLE lt_tab OCCURS DATa(occ).
*
*  cl_demo_output=>display( lt_tab ).

DATA itab TYPE TABLE OF mara.

DESCRIBE TABLE itab OCCURS DATA(occ).

"ASSERT occ = CAST cl_abap_tabledescr(
 " cl_abap_typedescr=>describe_by_data( itab ) )->initial_size.
cl_demo_output=>display( itab ).
