class ZCL_TT_CNTRY_DERIVATION definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_USMD_RULE_SERVICE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TT_CNTRY_DERIVATION IMPLEMENTATION.


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


  method IF_EX_USMD_RULE_SERVICE~DERIVE_ENTITY.

 IF lines( ct_data ) = 1.
      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<fs_field>).
*
*        IF <fs_field> IS ASSIGNED.
*          ASSIGN COMPONENT 'RFE_POST' OF STRUCTURE <fs_field> TO FIELD-SYMBOL(<fs_result>).
*
*          IF <fs_result> = 'AP' AND <fs_result> IS ASSIGNED.
*            ASSIGN COMPONENT 'REF_POSTA' OF STRUCTURE <fs_field> TO <fs_result>.

        IF <fs_field> is ASSIGNED.
          ASSIGN COMPONENT 'REF_POSTA' OF STRUCTURE <fs_field> to FIELD-SYMBOL(<fs_result>).

            IF <fs_result> IS ASSIGNED and <fs_result> = 'IN'.

            ASSIGN COMPONENT 'LANGU_COM' OF STRUCTURE <fs_field> TO <fs_result>.

            IF <fs_result> IS ASSIGNED.
              <fs_result> = 'EN'.
            ENDIF.

        ENDIF.

    ENDIF.
   ENDLOOP.
   endif.
  endmethod.
ENDCLASS.
