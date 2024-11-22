CLASS zcl_eml_test1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EML_TEST1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_account TYPE TABLE FOR UPDATE zi_account,
          ls_account LIKE LINE OF lt_account.
    DATA: lt_transaction TYPE TABLE FOR UPDATE zi_account\\Transaction,
          ls_transaction LIKE LINE OF lt_transaction.

    READ ENTITIES OF zi_account
    ENTITY Account
    ALL FIELDS WITH VALUE #( ( %key-AccountId = '002' ) )
    RESULT DATA(lt_result_account)
    ENTITY Account BY \_transaction
    ALL FIELDS WITH VALUE #( ( %key-AccountId = '002' ) )
    RESULT DATA(lt_result_transaction).

    LOOP AT lt_result_account INTO DATA(ls_header).
      ls_account = CORRESPONDING #( ls_header ).
      ls_account-AccountType = 'LOAN'.
      ls_account-%control-AccountType = if_abap_behv=>mk-on.
      APPEND ls_account TO lt_account.
    ENDLOOP.

    LOOP AT lt_result_transaction INTO DATA(ls_item).
      ls_transaction = CORRESPONDING #( ls_item ).
      ls_transaction-TransactionType = 'CREDIT'.
      ls_transaction-%control-TransactionType = if_abap_behv=>mk-on.
      APPEND ls_transaction TO lt_transaction.
    ENDLOOP.

    MODIFY ENTITIES OF zi_account
    ENTITY Account
    UPDATE FROM lt_account
    ENTITY Transaction
    UPDATE FROM lt_transaction
    FAILED DATA(failed)
    REPORTED DATA(reported).

    IF ( failed IS INITIAL OR reported IS INITIAL ).
      COMMIT ENTITIES.
      out->write( 'Updated' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
