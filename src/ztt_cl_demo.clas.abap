class ZTT_CL_DEMO definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces ZTT_IF_BADI_DEMO .
protected section.
private section.
ENDCLASS.



CLASS ZTT_CL_DEMO IMPLEMENTATION.


  method ZTT_IF_BADI_DEMO~GET_DATA.

    select * from mara into TABLE @data(lt_mara).


  endmethod.
ENDCLASS.
