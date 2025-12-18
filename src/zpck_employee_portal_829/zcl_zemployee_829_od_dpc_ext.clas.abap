class ZCL_ZEMPLOYEE_829_OD_DPC_EXT definition
  public
  inheriting from ZCL_ZEMPLOYEE_829_OD_DPC
  create public .

public section.
protected section.

  methods ZEMP_LOGIN_829SE_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZEMPLOYEE_829_OD_DPC_EXT IMPLEMENTATION.


  method ZEMP_LOGIN_829SE_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->ZEMP_LOGIN_829SE_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

    DATA: lv_employeeid TYPE pernr_d,
        lv_password   TYPE zpassword,
        lt_key_tab    TYPE /iwbep/t_mgw_tech_pairs,
        ls_key        TYPE /iwbep/s_mgw_tech_pair,
        ls_login      TYPE ZDT_EMP_CRED_829.

  " Get key values from the request
  lt_key_tab = io_tech_request_context->get_keys( ).

  LOOP AT lt_key_tab INTO ls_key.
    CASE ls_key-name.
      WHEN 'EMPLOYEEID'.
        lv_employeeid = ls_key-value.
      WHEN 'PASSWORD'.
        lv_password = ls_key-value.
    ENDCASE.
  ENDLOOP.

  " Check if the login credentials exist in the table
  SELECT SINGLE * INTO @ls_login
    FROM ZDT_EMP_CRED_829
    WHERE employee_id = @lv_employeeid
      AND passcode  = @lv_password.

  IF sy-subrc = 0.
    " Credentials are valid – return employee ID and success message
    er_entity = VALUE ZEMPLOYEE_LOGIN_829_S(
                    employee_id = lv_employeeid
                    passcode   = 'Login Successful'
                ).
  ELSE.
    " Invalid login – return error message
    er_entity = VALUE ZEMPLOYEE_LOGIN_829_S(
                    employee_id = lv_employeeid
                    passcode   = 'Invalid Credentials'
                ).
  ENDIF.
  endmethod.
ENDCLASS.
