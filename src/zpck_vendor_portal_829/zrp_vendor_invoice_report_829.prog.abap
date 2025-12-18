*&---------------------------------------------------------------------*
*& Report ZRP_VENDOR_INVOICE_REPORT_829
*&---------------------------------------------------------------------*
REPORT zrp_vendor_invoice_report_829.

TYPE-POOLS: sfp.

DATA: lv_func      TYPE funcname VALUE 'ZF_VENDOR_INVOICE_829',
      lv_out       TYPE sfpoutputparams,
      lv_doc       TYPE sfpdocparams,
      lv_form      TYPE fpformoutput,
      lv_filename  TYPE string,
      lv_path      TYPE string,
      lv_fullpath  TYPE string.

"--- AMDP result table types + 1 header row
DATA: gt_header TYPE zvendorinvoiceheader_829_t,
      gt_items  TYPE zvendorinvoiceitem_829_t.


PARAMETERS: p_belnr TYPE re_belnr.

START-OF-SELECTION.

  "1. Get data from AMDP (HANA)

  CALL METHOD zvend_invoice_pdf_829=>get_invoice_data
    EXPORTING
      iv_doc_num = p_belnr
    IMPORTING
      et_header  = gt_header
      et_items   = gt_items
      .


 IF gt_header IS INITIAL.
  MESSAGE 'No vendor invoice data found for this document' TYPE 'E'.
ENDIF.


  "2. Output parameters for Adobe
  lv_out-nodialog = abap_true.
  lv_out-getpdf   = abap_true.
  lv_out-preview  = abap_true.
  lv_out-dest     = 'LP01'.

  lv_doc-dynamic = abap_true.
  lv_doc-langu   = sy-langu.

  "3. Get generated FM name for the form
  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = lv_func
    IMPORTING
      e_funcname = lv_func
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    MESSAGE 'Error determining Adobe form FM name' TYPE 'E'.
  ENDIF.

  "4. Open form job
  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = lv_out
    EXCEPTIONS
      OTHERS = 4.
  IF sy-subrc <> 0.
    MESSAGE 'FP_JOB_OPEN failed' TYPE 'E'.
  ENDIF.

  "5. Call the Adobe form
CALL FUNCTION lv_func
  EXPORTING
    /1bcdwb/docparams = lv_doc
    iv_doc_num        = p_belnr          " scalar
    wa_header         = gt_header        " ✅ table type
    lt_item           = gt_items         " table type
    date              = sy-datum         " if in context
  IMPORTING
    /1bcdwb/formoutput = lv_form
  EXCEPTIONS
    usage_error    = 1
    system_error   = 2
    internal_error = 3
    OTHERS         = 4.
EXPORT lv_form TO MEMORY ID 'C_MEMORY'.

  IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ELSE.
  EXPORT lv_form TO MEMORY ID 'C_MEMORY'.
  MESSAGE 'Adobe Form processed successfully' TYPE 'S'.
ENDIF.



  "6. Close form job
  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      OTHERS = 4.
