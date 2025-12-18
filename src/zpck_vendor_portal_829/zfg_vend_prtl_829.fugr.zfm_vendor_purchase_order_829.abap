FUNCTION ZFM_VENDOR_PURCHASE_ORDER_829.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_VENDOR_ID) TYPE  LIFNR
*"  EXPORTING
*"     VALUE(ES_PURCHASE_ORDER) TYPE  ZVENDORPURCHASEORDER_829_T
*"----------------------------------------------------------------------
DATA: lv_vendor_id TYPE lifnr.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = iv_vendor_id
    IMPORTING
      output = lv_vendor_id.
  CALL METHOD zvend_purchase_order_829=>get_data
    EXPORTING
      i_vendor_id = lv_vendor_id
    IMPORTING
      et_po_data  = es_purchase_order
      .





ENDFUNCTION.
