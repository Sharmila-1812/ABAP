@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'New Trans Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TRANSACTION1 as select from znb_transactn1
association to parent ZI_ACCOUNT1 as _account  on $projection.AccUuid = _account.AccUuid
 //and $projection.AccountId = _account.AccountId
{
    key znb_transactn1.trans_uuid as TransUuid,
    znb_transactn1.acc_uuid as AccUuid,
    znb_transactn1.transaction_type as TransactionType,
    @Semantics.amount.currencyCode: 'CurrencyKey'
    znb_transactn1.amount as Amount,
    znb_transactn1.currency_key as CurrencyKey,
    znb_transactn1.trans_date as TransDate,
    znb_transactn1.description as Description,
    _account
}
