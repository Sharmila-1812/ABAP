@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Customer CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNB_I_CUSTOMER as select from znb_customer 
association [1] to I_CalendarDate as _calendar on $projection.DateOfBirth = _calendar.CalendarDate
association [0..*] to ZNB_I_ACCOUNT as _account on $projection.CustomerId = _account.CustomerId
{
     key znb_customer.customer_id as CustomerId,
     znb_customer.name as Name,
     znb_customer.address as Address,
     znb_customer.contact as Contact,
     znb_customer.email as Email,
     znb_customer.date_of_birth as DateOfBirth,
     _calendar.CalendarWeek as BirthDayWeek,
     _account
}
