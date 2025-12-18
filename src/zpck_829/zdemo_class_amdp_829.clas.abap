CLASS zdemo_class_amdp_829 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    TypES: BEGIN OF ty_head,
           vbeln tyPE vbrk-vbeln,
           fkdat tyPE vbrk-fkdat,
           end of ty_head .
    TyPES: BEGIN OF ty_item,
           vbeln tyPE vbap-vbeln,
           kunnr_ana tyPE vbap-kunnr_ana,
           NETWR tyPE vbap-netwr,
           WAERK tyPE vbap-waerk,
           end OF ty_ITEM.

   typeS: it_head type tablE of ty_head,
          it_item type taBLE of ty_item.

   CLASS-METHODS get_data
     IMPORTING
        VALUE(i_mandt) TYPE mandt
        VALUE(i_vbeln) TYPE vbrk-vbeln
      EXPORTING
        VALUE(it_head)  TYPE  it_head.

   CLASS-METHODS get_ITEM
     IMPORTING
        VALUE(i_mandt) TYPE mandt
        VALUE(i_vbeln) TYPE vbrk-vbeln
      EXPORTING
        VALUE(it_ITEM)  TYPE  it_ITEM.




  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zdemo_class_amdp_829 IMPLEMENTATION.

methOD get_data
    BY DATABASE PROCEDURE
    FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING vbrk .

    it_head = select a.vbeln , a.fkdat from vbrk as a
    where a.mandt = :i_mandt
    and a.vbeln = :i_vbeln;

endmeTHOD.

METHOD get_ITEM
    BY DATABASE PROCEDURE
    FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING vbrk vbap.
    it_item = select a.vbeln, b.kunnr_ana, b.netwr, b.waerk from vbrk as a
    left outer join vbap as b on b.mandt = a.mandt and b.vbeln= a.vbeln
    where a.mandt=:i_mandt
    and a.vbeln=i_vbeln;

endmETHOD.
ENDCLASS.
