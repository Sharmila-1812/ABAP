@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Account CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZNB_I_ACCOUNT
  as select from znb_account
  //association [1] to ZNB_I_CUSTOMER as _customer on $projection.CustomerId = _customer.CustomerId
  association [1..*] to ZNB_I_TRANSACTION as _transaction on $projection.AccountId = _transaction.AccountId
  
{
  key account_id                                    as AccountId,
      customer_id                                   as CustomerId,
      account_type                                  as AccountType,
      case account_type
       when 'SAVINGS' then 'Savings Account'
       when 'CURRENT' then 'Current Account'
       when 'LOAN' then 'Loan Account'
       else 'Others'
       end                                          as AccTypeDesc,
      @Semantics.amount.currencyCode: 'CurrencyKey'
      balance                                       as Balance,
      currency_key                                  as CurrencyKey,
      date_created                                  as DateCreated,
     // _customer,
      _transaction,
      @Semantics.amount.currencyCode : 'CurrencyInUSD'
      currency_conversion( amount => balance,
       source_currency => currency_key,
       target_currency => cast( 'USD' as abap.cuky(5)),
       exchange_rate_date => date_created ) as BalanceAmountInUSD,
      cast( 'USD' as abap.cuky(5))                  as CurrencyInUSD
}
