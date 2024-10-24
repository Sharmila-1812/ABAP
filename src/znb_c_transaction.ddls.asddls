@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZNB_C_TRANSACTION as select from ZNB_I_TRANSACTION
{
    key TransactionId,
    AccountId,
    TransactionType,
    @Semantics.amount.currencyCode: 'CurrencyKey'
    Amount,
    CurrencyKey,
    TransDate,
    Description,
    @Semantics.amount.currencyCode: 'CurrencyInUSD'
    TransAmountInUSD,
    CurrencyInUSD
    /* Associations */
   // _account
}
