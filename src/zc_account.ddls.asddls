
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for account'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 typeName: 'Account',
 typeNamePlural: 'Accounts'
}
}
define root view entity ZC_ACCOUNT
  provider contract transactional_query
  as projection on ZI_ACCOUNT
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
       @UI.lineItem: [ { position: 10} ]
      @EndUserText.label: 'Acc ID'
  key AccountId,
      @UI.selectionField: [{ position: 10 }]
      @UI.identification: [ {position: 20} ]
      @EndUserText.label: 'Customer ID'
      CustomerId,
      @UI.lineItem: [ { position: 20} ]
      @UI.identification: [ {position: 30} ]
      @EndUserText.label: 'Account Type'
      AccountType,
      @UI.lineItem: [ { position: 30} ]
      @UI.identification: [ {position: 40} ]
      @EndUserText.label: 'Acc Balance'
      @Semantics.amount.currencyCode: 'CurrencyKey'
      Balance,
      CurrencyKey,
      @UI.lineItem: [ { position: 40} ]
      @UI.identification: [ {position: 50} ]
      @EndUserText.label: 'Created Date'
      DateCreated,
      /* Associations */
      _transaction: redirected to composition child ZC_TRANSACTION

}
