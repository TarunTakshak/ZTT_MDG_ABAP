*****           Implementation of object type ZWF_OB_LEV           *****
INCLUDE <OBJECT>.
BEGIN_DATA OBJECT. " Do not change.. DATA is generated
* only private members may be inserted into structure private
DATA:
" begin of private,
"   to declare private attributes remove comments and
"   insert private attributes here ...
" end of private,
  BEGIN OF KEY,
      EMP_ID LIKE P0105-PERNR,
  END OF KEY,
      LAST_NAME TYPE PA0002-NACHN.
END_DATA OBJECT. " Do not change.. DATA is generated

BEGIN_METHOD ZTTWFFMLEAVE CHANGING CONTAINER.
DATA:
      IVEMPID TYPE PA0002-PERNR,
      EVMANAGER TYPE PA0002-NACHN.
  SWC_GET_ELEMENT CONTAINER 'IvEmpId' IVEMPID.
  CALL FUNCTION 'ZTT_WF_FM_LEAVE'
    EXPORTING
      IV_EMP_ID = IVEMPID
    IMPORTING
      EV_MANAGER = EVMANAGER
    EXCEPTIONS
      OTHERS = 01.
  CASE SY-SUBRC.
    WHEN 0.            " OK
       SWC_SET_ELEMENT CONTAINER 'EvManager' EVMANAGER.
    WHEN OTHERS.       " to be implemented
  ENDCASE.
 " SWC_SET_ELEMENT CONTAINER 'EvManager' EVMANAGER.
END_METHOD.

GET_PROPERTY LAST_NAME CHANGING CONTAINER.
  SWC_SET_ELEMENT CONTAINER 'Last_Name' OBJECT-LAST_NAME.
END_PROPERTY.
