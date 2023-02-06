class ZTT_CL_BP_GRP definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_BP_GRP IMPLEMENTATION.


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

    IF sy-uname = 'TAKSHAKT'.
      IF lines( ct_data ) EQ 1.
        LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fs_data>).
          IF <fs_data> IS ASSIGNED.
            ASSIGN COMPONENT 'BU_TYPE' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_field>).
            IF <fs_field> IS ASSIGNED.
              IF <fs_field> EQ 2.
                ASSIGN COMPONENT 'BU_GROUP' OF STRUCTURE <fs_data> TO <fs_field>.
                IF <fs_field> IS ASSIGNED.
                  <fs_field> = 'BP02'.
                ENDIF.
                IF <fs_field> EQ 1.
                  ASSIGN COMPONENT 'BU_GROUP' OF STRUCTURE <fs_data> TO <fs_field>.
                  CHECK <fs_field> IS ASSIGNED.
                  <fs_field> = 'ABAD'.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
