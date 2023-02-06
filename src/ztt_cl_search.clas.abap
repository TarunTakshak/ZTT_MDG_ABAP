class ZTT_CL_SEARCH definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_SEARCH IMPLEMENTATION.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_FINAL.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_CREQUEST_START.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_FINAL.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_HIERARCHY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_EDITION_START.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY.
  endmethod.


  method IF_EX_USMD_RULE_SERVICE~CHECK_ENTITY_HIERARCHY.
  endmethod.


  METHOD if_ex_usmd_rule_service~derive_entity.


    CALL METHOD cl_usmd_app_context=>get_context
      RECEIVING
        eo_context = DATA(lo_context).                 " Application Context

    CALL METHOD lo_context->get_attributes
      IMPORTING
        ev_crequest_id = DATA(lv_crid).                " Change Request

    CALL METHOD io_model->read_entity_data_all
      EXPORTING
        i_fieldname    = 'BP_HEADER'                   " Financial MDM: Field Name
        if_active      = abap_false                    " Financial MDM: General Indicator
        i_crequest     = lv_crid                       " Change Request
      IMPORTING
        et_data_entity = DATA(lt_data_entity).                 " Data for Entity Types

    READ TABLE lt_data_entity  WITH KEY usmd_entity = 'BP_HEADER' INTO DATA(ls_data_entity).

    ASSIGN ls_data_entity-r_t_data->* TO FIELD-SYMBOL(<fs_entity>).
    IF <fs_entity> IS ASSIGNED.
      LOOP AT <fs_entity> ASSIGNING FIELD-SYMBOL(<fs_final>).

        ASSIGN COMPONENT 'BU_TYPE' OF STRUCTURE <fs_final> TO FIELD-SYMBOL(<fs>).
        IF <fs> IS ASSIGNED.
          IF lines( ct_data ) EQ 1.
            LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fs_data>).
              IF <fs_data> IS ASSIGNED.
                IF <fs> EQ 2.
                  ASSIGN COMPONENT 'NAME_ORG1' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_field>).
                  IF <fs_field> IS ASSIGNED.
                    ASSIGN COMPONENT 'BU_SORT1' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_temp>).
                    IF <fs_temp> IS ASSIGNED.
                      <fs_temp> = <fs_field>.
                    ENDIF.
                  ENDIF.
                ENDIF.
                IF <fs> EQ 1.
                  ASSIGN COMPONENT 'NAME_LAST' OF STRUCTURE <fs_data> TO <fs_field>.
                  IF <fs_field> IS ASSIGNED.
                    ASSIGN COMPONENT 'BU_SORT1' OF STRUCTURE <fs_data> TO <fs_temp>.
                    IF <fs_temp> IS ASSIGNED.
                      <fs_temp> = <fs_field>.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.

      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
