@AbapCatalog.sqlViewName: 'ZQALOGIN829V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Login Service for QA Portal'
@Metadata.ignorePropagatedAnnotations: true
@OData.publish: true
define view Z_QA_LOGIN_CDS_829 as select from zdt_qa_login_829
{
    key username ,
    password,
    cast( 'Success' as abap.char(10) ) as login_status
}
