CLASS zcl_eml_delete DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EML_DELETE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_account TYPE TABLE FOR DELETE zi_account.
    DATA: lt_transaction TYPE TABLE FOR DELETE zi_account\\Transaction.


    READ ENTITIES OF zi_account
    ENTITY Account
    FIELDS ( AccountId )
    WITH VALUE #( ( %key-AccountId = ' 6' ) )
    RESULT DATA(lt_result_account)
    ENTITY Account BY \_transaction
    FIELDS ( TransactionId )
    WITH VALUE #( ( %key-AccountId = '001' ) )
    RESULT DATA(lt_result_transaction).

    lt_account = CORRESPONDING #( lt_result_account ).
    lt_transaction = CORRESPONDING #( lt_result_transaction ).

    MODIFY ENTITIES OF zi_account
    ENTITY Account
    DELETE FROM lt_account
    ENTITY Transaction
    DELETE FROM lt_transaction
    FAILED DATA(failed)
    REPORTED DATA(reported).

    IF ( failed IS INITIAL OR reported IS INITIAL ).
      COMMIT ENTITIES.
      out->write( 'Deleted' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
