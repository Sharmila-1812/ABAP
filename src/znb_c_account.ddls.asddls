@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Account Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZNB_C_ACCOUNT as select from ZNB_I_ACCOUNT
association [1..*] to ZNB_C_TRANSACTION as _transaction on $projection.AccountId = _transaction.AccountId
{
    key AccountId,
    CustomerId,
    AccountType,
    AccTypeDesc,
     @Semantics.amount.currencyCode: 'CurrencyKey'
    Balance,
    CurrencyKey,
    DateCreated,
    @Semantics.amount.currencyCode : 'CurrencyInUSD'
    BalanceAmountInUSD,
    CurrencyInUSD,
    /* Associations */
    //_customer,
    _transaction
}
