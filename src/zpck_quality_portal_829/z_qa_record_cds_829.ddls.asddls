@AbapCatalog.sqlViewName: 'ZQARECORD829V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Record Service for QA Portal'
@Metadata.ignorePropagatedAnnotations: true
@OData.publish: true
define view Z_QA_RECORD_CDS_829  as select from qamr
  inner join qals
    on qamr.prueflos = qals.prueflos
{
  key qamr.prueflos    as InspectionLot,       
      qamr.vorglfnr    as OperationNo,         
      qamr.merknr      as CharacteristicNo,   
      qamr.mbewertg    as ResultCode,          
 
      qals.werk        as Plant,             
      qals.art         as InspectionType,      
      qals.objnr       as ObjectNumber,       
      qals.obtyp       as ObjectType,          
      qals.stat35      as Status,              
      qals.selmatnr    as MaterialNumber       
}
