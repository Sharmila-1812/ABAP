CLASS zcl_eml_create_by DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EML_CREATE_BY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA: lt_transaction TYPE TABLE FOR CREATE zi_account\_transaction,
          ls_transaction LIKE LINE OF lt_transaction.

    DATA: lt_target LIKE ls_transaction-%target,
          ls_target LIKE LINE OF lt_target.

    ls_target = VALUE #( %cid = 'transaction1'
    Amount = '200' TransactionType = 'DEBIT' Description  = 'Amount Debited'
    CurrencyKey = 'USD' TransDate = sy-datum
    %control = VALUE #(
    Amount = if_abap_behv=>mk-on
    TransactionType = if_abap_behv=>mk-on
    CurrencyKey = if_abap_behv=>mk-on
    Description = if_abap_behv=>mk-on
    TransDate = if_abap_behv=>mk-on ) ).

    APPEND ls_target TO lt_target.

    ls_transaction = VALUE #( AccountId = '004'  %target = lt_target ).
    APPEND ls_transaction TO lt_transaction.
    CLEAR lt_target.

    MODIFY ENTITIES OF zi_account ENTITY Account

  CREATE BY \_transaction FROM lt_transaction
  MAPPED DATA(mapped)
  FAILED DATA(failed)
  REPORTED DATA(reported).


    IF ( failed IS INITIAL OR reported IS INITIAL ).
      COMMIT ENTITIES.
      out->write( 'Created By Association' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
