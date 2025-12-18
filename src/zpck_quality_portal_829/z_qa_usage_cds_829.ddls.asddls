@AbapCatalog.sqlViewName: 'ZQAUSAGE829V'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Usage Decision View'
@Metadata.ignorePropagatedAnnotations: true
@OData.publish: true
define view Z_QA_USAGE_CDS_829
  as select from qave
{
    key prueflos        as InspectionLotNo,     
    key zaehler         as SequenceNo,          
    key kzart           as InspectionLotType,

         vkatart        as UsageCatalog,        
         vwerks         as Plant,               
         vauswahlmg     as SelectedSet,        
         vcodegrp       as CodeGroup,          
         vcode          as UsageDecisionCode,   
         qkennzahl      as QualityScore,        
         vname          as DecisionBy,         
         vdatum         as DecisionDate,        
         vezeiterf      as DecisionTime,       
         vfolgeakti     as FollowUpAction,      
         vbewertung     as CodeValuation        
}
