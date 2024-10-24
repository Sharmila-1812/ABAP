@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Transaction CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNB_I_TRANSACTION
  as select from znb_transactn
 // association [1] to znb_account as _account on $projection.AccountId = _account.account_id
{
  key transaction_id                                as TransactionId,
      account_id                                    as AccountId,
      transaction_type                              as TransactionType,
      @Semantics.amount.currencyCode: 'CurrencyKey'
      amount                                        as Amount,
      currency_key                                  as CurrencyKey,
      trans_date                                    as TransDate,
      description                                   as Description,
     // _account,

//currency_conversion( amount => amount, source_currency => source_currency, target_currency => target_currency, exchange_rate_date => exchange_rate_date )
      @Semantics.amount.currencyCode : 'CurrencyInUSD'
      currency_conversion( amount => amount,
       source_currency => currency_key,
       target_currency => cast( 'USD' as abap.cuky(5)),
       exchange_rate_date => trans_date ) as TransAmountInUSD,
      cast( 'USD' as abap.cuky(5))                  as CurrencyInUSD
    

}
