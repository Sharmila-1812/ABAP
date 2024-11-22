@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'New Acct Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_ACCOUNT1 as select from znb_account1
composition[0..*] of ZI_TRANSACTION1  as _transaction
{
key znb_account1.acc_uuid as AccUuid,
znb_account1.customer_name as CustomerName,
znb_account1.account_type as AccountType,
@Semantics.amount.currencyCode: 'CurrencyKey'
znb_account1.balance as Balance,
znb_account1.currency_key as CurrencyKey,
znb_account1.date_created as DateCreated,
_transaction
}
