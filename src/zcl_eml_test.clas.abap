CLASS zcl_eml_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EML_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
***Read EML
* READ ENTITIES OF zi_account
* ENTITY Account
* ALL FIELDS WITH VALUE #( ( %key-AccountId = '001' ) )
* RESULT DATA(result)
* FAILED DATA(failed)
* REPORTED DATA(reported).
*out->write( result ).
***Read By Association EML
* READ ENTITIES OF zi_account
* ENTITY Account BY \_transaction
* ALL FIELDS WITH VALUE #( ( %key-AccountId = '001' ) )
* RESULT DATA(result1).
* out->write( result1 ).

    DATA: lt_account TYPE TABLE FOR CREATE zi_account,
          ls_account LIKE LINE OF lt_account.

    DATA: lt_transaction TYPE TABLE FOR CREATE zi_account\_transaction,
          ls_transaction LIKE LINE OF lt_transaction.

    DATA: lt_target LIKE ls_transaction-%target,
          ls_target LIKE LINE OF lt_target.

    ls_account = VALUE #( %cid = 'account1' CustomerId ='3'
    AccountType = 'SAVINGS' Balance = '216'
    CurrencyKey = 'USD' DateCreated = sy-datum
    %control = VALUE #( CustomerId = if_abap_behv=>mk-on
    AccountType = if_abap_behv=>mk-on
    Balance = if_abap_behv=>mk-on
    CurrencyKey = if_abap_behv=>mk-on
    DateCreated = if_abap_behv=>mk-on ) ).

    APPEND ls_account TO  lt_account.

    ls_account = VALUE #( %cid = 'account2' CustomerId ='5'
    AccountType = 'CURRENT' Balance = '56'
    CurrencyKey = 'USD' DateCreated = sy-datum
    %control = VALUE #( CustomerId = if_abap_behv=>mk-on
    AccountType = if_abap_behv=>mk-on
    Balance = if_abap_behv=>mk-on
    CurrencyKey = if_abap_behv=>mk-on
    DateCreated = if_abap_behv=>mk-on ) ).

    APPEND ls_account TO  lt_account.

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

     ls_target = VALUE #( %cid = 'transaction2'
    Amount = '200' TransactionType = 'CREDIT' Description  = 'Amount credited'
    CurrencyKey = 'INR' TransDate = sy-datum
    %control = VALUE #(
    Amount = if_abap_behv=>mk-on
    TransactionType = if_abap_behv=>mk-on
    CurrencyKey = if_abap_behv=>mk-on
    Description = if_abap_behv=>mk-on
    TransDate = if_abap_behv=>mk-on ) ).

    APPEND ls_target TO lt_target.

    ls_transaction = VALUE #( %cid_ref = 'account1' %target = lt_target ).
    APPEND ls_transaction to lt_transaction.
    clear lt_target.


     ls_target = VALUE #( %cid = 'transaction3'
    Amount = '2000' TransactionType = 'DEBIT' Description  = 'Amount Debited'
    CurrencyKey = 'USD' TransDate = sy-datum
    %control = VALUE #(
    Amount = if_abap_behv=>mk-on
    TransactionType = if_abap_behv=>mk-on
    CurrencyKey = if_abap_behv=>mk-on
    Description = if_abap_behv=>mk-on
    TransDate = if_abap_behv=>mk-on ) ).

    APPEND ls_target TO lt_target.

    ls_transaction = VALUE #( %cid_ref = 'account2' %target = lt_target ).
    APPEND ls_transaction to lt_transaction.

    MODIFY ENTITIES OF zi_account ENTITY Account
    CREATE From lt_account
    CREATE BY \_transaction FROM lt_transaction
    MAPPED DATA(mapped)
    FAILED DATA(failed)
    REPORTED DATA(reported).

    if ( failed is initial or reported is initial ).
    COMMIT ENTITIES.
    out->write( 'Created' ).
        ENDIF.

  ENDMETHOD.
ENDCLASS.
