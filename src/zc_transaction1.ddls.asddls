@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'New Projection view for Transaction'
@Metadata.ignorePropagatedAnnotations: true
@UI: {
 headerInfo: {
 typeName: 'Transaction',
 typeNamePlural: 'Transactions'
}
}
define view entity ZC_TRANSACTION1
  as projection on ZI_TRANSACTION1
{
      @UI.facet: [ {
      id: 'idTransaction',
      type: #IDENTIFICATION_REFERENCE,
      label: 'Transaction Info',
      position: 10
      }]
      @UI.identification: [ {position: 10} ]
      @UI.lineItem: [{ type: #FOR_ACTION, dataAction: 'updateAmount' , label: 'Modify Amount' }]
      @EndUserText.label: 'Transaction Uuid'
  key TransUuid,   
  @UI.identification: [ {position: 20} ]  
  @EndUserText.label: 'Account Uuid'
  AccUuid,
      @UI.lineItem: [ { position: 10} ]
      @UI.selectionField: [{ position: 20 }]
      @UI.identification: [ {position: 40} ]
      @EndUserText.label: 'Transaction Type'
      TransactionType,
      @UI.lineItem: [ { position: 20} ]
      @UI.identification: [ {position: 50} ]
      @EndUserText.label: 'Transaction Amt'
      @Semantics.amount.currencyCode: 'CurrencyKey'
      Amount,
      CurrencyKey,
      @UI.lineItem: [ { position: 30} ]
      @UI.identification: [ {position: 60} ]
      @UI.selectionField: [{ position: 30 }]
      @EndUserText.label: 'Transaction Date'
      TransDate,
      @UI.lineItem: [ { position: 40} ]
      @UI.identification: [ {position: 70} ]
      @EndUserText.label: 'Transaction Desc'
      Description,
      /* Associations */
      _account : redirected to parent ZC_ACCOUNT1
}
