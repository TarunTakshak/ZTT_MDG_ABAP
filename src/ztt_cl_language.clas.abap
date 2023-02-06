class ZTT_CL_LANGUAGE definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_LANGUAGE IMPLEMENTATION.


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
     if sy-uname = 'TAKSHAKT'.
    IF lines( ct_data ) EQ 1.
      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fs_data>).
        IF <fs_data> IS ASSIGNED.
          ASSIGN COMPONENT 'REF_POSTA' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_field>).
          ASSIGN COMPONENT 'LANGU_COM' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_temp>).

          IF <fs_field> IS ASSIGNED AND <fs_temp> IS ASSIGNED.

            <fs_temp> = SWITCH string( <fs_field>
                                       WHEN 'DE' THEN 'DE'
                                       WHEN 'GB' THEN 'EN'
                                       WHEN 'IN' THEN 'EN'
                                       WHEN 'KR' THEN 'KO' ).

          ENDIF.
        ENDIF.
      ENDLOOP.


    ENDIF.
    endif.

  ENDMETHOD.
ENDCLASS.
