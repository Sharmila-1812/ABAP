@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'New Projection view for account'
@Metadata.ignorePropagatedAnnotations: true
@UI: {
 headerInfo: {
 typeName: 'Account',
 typeNamePlural: 'Accounts'
}
}
define root view entity ZC_ACCOUNT1
  provider contract transactional_query
  as projection on ZI_ACCOUNT1

{
      @UI.facet: [ {
       id: 'idAccount',
       type: #IDENTIFICATION_REFERENCE,
       label: 'Accounts',
       position: 10
       },
        {
      id: 'idTransaction',
      type: #LINEITEM_REFERENCE,
      label: 'Transaction Info',
      position: 20,
      targetElement: '_transaction'
      }]

      @UI.identification: [ {position: 10} ]
      @UI.lineItem: [{ type: #FOR_ACTION, dataAction: 'updateBalance' , label: 'Modify Balance' }]
      @EndUserText.label: 'Account Uuid'
  key AccUuid,   
      @UI.selectionField: [{ position: 20 }]
      @UI.identification: [ {position: 30} ]
      @EndUserText.label: 'Customer Name'
      CustomerName,
      @UI.selectionField: [{ position: 30 }]
      @UI.identification: [ {position: 40} ]
      @UI.lineItem: [ { position: 20} ]
      @EndUserText.label: 'Account Type'
      AccountType,
      @UI.lineItem: [ { position: 30}, {type: #FOR_ACTION, dataAction: 'SETZERO' , label: 'Set as Zero'}]
      //{position: 50},{ type: #FOR_ACTION, dataAction: 'UpdateBalance' , label: 'Modify Balance' }]
      @UI.identification: [ {position: 50} ]
      @EndUserText.label: 'Acc Balance'
      @Semantics.amount.currencyCode: 'CurrencyKey'
      Balance,
      CurrencyKey,
      @UI.lineItem: [ { position: 40} ]
      @UI.identification: [ {position: 60} ]
      @EndUserText.label: 'Created Date'
      DateCreated,
      /* Associations */
      _transaction : redirected to composition child ZC_TRANSACTION1
}
