@EndUserText.label: 'Custom Entity for Customer Data'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_CUSTOMER_CUSTOM'
    }
}
@UI: {
  headerInfo: {
    typeName: 'Customer',
    typeNamePlural: 'Customers',
    title: { value: 'customer_id' }
  }
}
define root custom entity ZCE_SHA_Customer_CUSTOM
{
      @UI.facet   : [ {
      id          : 'idCustomer',
      type        : #IDENTIFICATION_REFERENCE,
      label       : 'Customer Info',
      position    : 10
      }]
      @UI.lineItem: [{ position: 10 }]
      @UI.selectionField : [{position: 10}]
      @UI.identification: [{position: 10}]
  key customer_id : z_de_cust_id;
  @UI.lineItem: [{ position : 20 }]
  @UI.identification: [{ position : 20 }]
  @UI.selectionField: [{ position : 10 }]
  @EndUserText.label: 'Name'
  Name: abap.char(30) ;
  @UI.identification: [{ position : 30 }]
  @EndUserText.label: 'Addr'
  Address : abap.char(100);
  @UI.lineItem: [{ position : 40 }]
  @UI.identification: [{ position : 40 }]
  @EndUserText.label: 'Phone Number'
  Contact: abap.char(10);
  @UI.lineItem: [{ position : 50 }]
  @UI.identification: [{ position : 50 }]
  @UI.selectionField: [{ position : 20 }]
  @EndUserText.label: 'Mail Id'
  Email : abap.char(50);
  @UI.identification: [{ position : 60 }]
  @EndUserText.label: 'DoB'
  @UI.selectionField: [{ position : 30 }]
  date_of_birth : abap.dats;
}
