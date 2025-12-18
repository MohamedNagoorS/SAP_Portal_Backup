FUNCTION ZFM_LOGIN_829.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CUSTOMER_ID) TYPE  KUNNR
*"     VALUE(PASSCODE) TYPE  Z_USERPASS_829_DE
*"  EXPORTING
*"     VALUE(STATUS) TYPE  CHAR30
*"----------------------------------------------------------------------
DATA: lv_password TYPE char30.
  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input         = customer_ID
   IMPORTING
     OUTPUT        = customer_ID
            .

  SELECT SINGLE passcode INTO @lv_password FROM ZDT_CUS_CRED_829
   WHERE Customer_ID = @CUSTOMER_ID.

  IF lv_password = passcode and sy-subrc = 0.
  status  = 'Login Sucess'.

  ELSE.
 status  = 'Login Fail'.

  ENDIF.

ENDFUNCTION.
