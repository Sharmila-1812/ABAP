
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Transaction'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 typeName: 'Transaction',
 typeNamePlural: 'Transactions'
}
}
define view entity ZC_TRANSACTION as projection on ZI_TRANSACTION
{
    @UI.facet: [ {
  id: 'idTransaction',
  type: #IDENTIFICATION_REFERENCE,
  label: 'Transaction Info',
  position: 10
  }]
  @UI.identification: [ {position: 10} ]
  @EndUserText.label: 'Transaction ID'
  key TransactionId,
  @UI.selectionField: [{ position: 10 }]
  @UI.identification: [ {position: 20} ]
  @EndUserText.label: 'Acc ID'
  AccountId,
  @UI.lineItem: [ { position: 10} ]
  @UI.selectionField: [{ position: 20 }]
  @UI.identification: [ {position: 30} ]
  @EndUserText.label: 'Transaction Type'
  TransactionType,
  @UI.lineItem: [ { position: 20} ]
  @UI.identification: [ {position: 40} ]
  @EndUserText.label: 'Transaction Amt'
  @Semantics.amount.currencyCode: 'CurrencyKey'
  Amount,
  CurrencyKey,
  @UI.lineItem: [ { position: 30} ]
  @UI.identification: [ {position: 50} ]
  @UI.selectionField: [{ position: 30 }]
  @EndUserText.label: 'Transaction Date'
  TransDate,
  @UI.lineItem: [ { position: 40} ]
  @UI.identification: [ {position: 60} ]
  @EndUserText.label: 'Transaction Desc'
  Description,
  _account : redirected to parent zc_account
}
