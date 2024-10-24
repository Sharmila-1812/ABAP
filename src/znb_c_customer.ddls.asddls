@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
//@OData.publish: true
define view entity ZNB_C_CUSTOMER as select from ZNB_I_CUSTOMER
association [0..*] to ZNB_C_ACCOUNT as _account on $projection.CustomerId = _account.CustomerId
{
    
    key ZNB_I_CUSTOMER.CustomerId,
    ZNB_I_CUSTOMER.Name,
    ZNB_I_CUSTOMER.Address,
    ZNB_I_CUSTOMER.Contact,
    ZNB_I_CUSTOMER.Email,
    ZNB_I_CUSTOMER.DateOfBirth,
    ZNB_I_CUSTOMER.BirthDayWeek,
    _account
}
