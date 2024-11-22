CLASS zcl_eml_create DEFINITION
  PUBLIC
    FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EML_CREATE IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

    DATA: lt_account TYPE TABLE FOR CREATE zi_account,
          ls_account LIKE LINE OF lt_account.


    ls_account = VALUE #( %cid = 'account1' CustomerId ='2'
    AccountType = 'LOAN' Balance = '2000'
    CurrencyKey = 'INR' DateCreated = sy-datum
    %control = VALUE #( CustomerId = if_abap_behv=>mk-on
    AccountType = if_abap_behv=>mk-on
    Balance = if_abap_behv=>mk-on
    CurrencyKey = if_abap_behv=>mk-on
    DateCreated = if_abap_behv=>mk-on ) ).

    APPEND ls_account TO  lt_account.

   MODIFY ENTITIES OF zi_account ENTITY Account
   CREATE FROM lt_account
   MAPPED DATA(mapped)
   FAILED DATA(failed)
   REPORTED DATA(reported).

    DATA: lt_mapped_acc LIKE mapped-account.
    lt_mapped_acc = CORRESPONDING #( mapped-account ).

    IF ( failed IS INITIAL OR reported IS INITIAL ).
      COMMIT ENTITIES.
      out->write( 'Created' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
