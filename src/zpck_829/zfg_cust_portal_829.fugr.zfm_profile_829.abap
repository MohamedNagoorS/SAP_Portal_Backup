FUNCTION zfm_profile_829.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CUSTOMER_ID) TYPE  KUNNR
*"  EXPORTING
*"     VALUE(ES_PROFILE) TYPE  ZUSERPROFILE_829_S
*"----------------------------------------------------------------------
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = iv_customer_ID
    IMPORTING
      output = iv_customer_ID.

  SELECT SINGLE kunnr, land1, name1, ort01, stras, pstlz
    INTO (@es_profile-customer_id,@es_profile-country,@es_profile-name,@es_profile-city,@es_profile-street,@es_profile-postal_code)
    FROM kna1 WHERE kunnr = @iv_customer_id.

ENDFUNCTION.
