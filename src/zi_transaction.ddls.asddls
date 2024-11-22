@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TRANSACTION as select from znb_transactn
association to  parent ZI_ACCOUNT  as  _account  on  $projection.AccountId = _account.AccountId
{
    key znb_transactn.transaction_id as TransactionId,
    _account.AccountId as AccID,
    znb_transactn.account_id as AccountId,
    znb_transactn.transaction_type as TransactionType,
    @Semantics.amount.currencyCode: 'CurrencyKey'
    znb_transactn.amount as Amount,
    znb_transactn.currency_key as CurrencyKey,
    znb_transactn.trans_date as TransDate,
    znb_transactn.description as Description,
   _account
}
