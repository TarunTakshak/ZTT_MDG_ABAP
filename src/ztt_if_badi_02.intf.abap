interface ZTT_IF_BADI_02
  public .


  interfaces IF_BADI_INTERFACE .

  methods MOVE_DATA
    importing
      !IV_CR_TYPE type USMD_CREQUEST_TYPE
    changing
      !ET_USMD type ZTT_TT_USMD110C .
endinterface.
