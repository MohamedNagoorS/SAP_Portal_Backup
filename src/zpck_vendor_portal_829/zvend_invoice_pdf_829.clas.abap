CLASS zvend_invoice_pdf_829 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_invoice_data
      IMPORTING
        VALUE(iv_doc_num) TYPE re_belnr   "DOCUMENT_NO
      EXPORTING
        VALUE(et_header)  TYPE zvendorinvoiceheader_829_t
        VALUE(et_items)   TYPE zvendorinvoiceitem_829_t.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvend_invoice_pdf_829 IMPLEMENTATION.
METHOD get_invoice_data
    BY DATABASE PROCEDURE
    FOR HDB
    LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING rbkp rseg lfa1 ekpo rbkp.


    et_header =
      SELECT
        rbkp.belnr   AS document_no,
        rbkp.bukrs   AS bukrs,
        lfa1.name1   AS vendor_name,
        rbkp.lifnr   AS vendor_id,
        rbkp.bldat   AS bldat,
        lfa1.stras   AS street,
        lfa1.ort01   AS city,
        lfa1.land1   AS country,
        lfa1.pstlz   AS postal
      FROM rbkp
      INNER JOIN lfa1 ON rbkp.lifnr = lfa1.lifnr
      WHERE rbkp.belnr = :iv_doc_num
      LIMIT 1;


et_items =
  SELECT
      rseg."BUZEI"         AS "BUZEI",
      rseg."EBELP"         AS "EBELP",
      rseg."MATNR"         AS "MATNR",
      ekpo."TXZ01"         AS "TXZ01",          -- Item Text
      rseg."MEINS"         AS "MEINS",
      rseg."MENGE"         AS "MENGE",
      rseg."PSTYP"         AS "PSTYP",
      rseg."WRBTR"         AS "WRBTR",          -- Amount
      rbkp."WAERS"         AS "WAERS"           -- Currency ← FIX ✔
  FROM "RSEG" AS rseg
  JOIN "EKPO" AS ekpo
       ON  rseg."EBELN" = ekpo."EBELN"
       AND rseg."EBELP" = ekpo."EBELP"
  JOIN "RBKP" AS rbkp
       ON rseg."BELNR" = rbkp."BELNR"
  WHERE rseg."BELNR" = :iv_doc_num;

  ENDMETHOD.
ENDCLASS.
