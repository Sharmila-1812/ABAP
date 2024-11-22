@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Account Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_ACCOUNT as select from znb_account
composition[0..*] of ZI_TRANSACTION as _transaction
{
    
    key znb_account.account_id as AccountId,
    znb_account.customer_id as CustomerId,
    znb_account.account_type as AccountType,
    @Semantics.amount.currencyCode: 'CurrencyKey'
    znb_account.balance as Balance,
    znb_account.currency_key as CurrencyKey,
    znb_account.date_created as DateCreated,
    _transaction
}
