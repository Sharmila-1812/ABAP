CLASS lhc_transaction DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS detBalance FOR DETERMINE ON SAVE
      IMPORTING keys FOR Transaction~detBalance.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Transaction RESULT result.

    METHODS updateAmount FOR MODIFY
      IMPORTING keys FOR ACTION Transaction~updateAmount.

ENDCLASS.

CLASS lhc_transaction IMPLEMENTATION.

  METHOD detBalance.

    READ ENTITIES OF zi_account1
      ENTITY Transaction
      FIELDS ( TransactionType Amount CurrencyKey )
      WITH VALUE #( ( %key-TransUuid = keys[ 1 ]-%key-TransUuid  ) )
      RESULT DATA(result_amount).
*
    READ ENTITIES OF zi_account1
     ENTITY Transaction BY \_account
     FIELDS ( Balance CurrencyKey )
     WITH VALUE #( ( %key-TransUuid = result_amount[ 1 ]-%key-TransUuid  ) )
     RESULT DATA(result_balance).

    IF sy-subrc = 0.
      " Check the transaction type and adjust the balance
      LOOP AT result_Amount INTO DATA(Trans_amt).
        CASE Trans_amt-TransactionType.
          WHEN 'CREDIT'. " Credit: Add to balance
            IF ( result_balance[ 1 ]-CurrencyKey  = result_amount[ 1 ]-CurrencyKey  ).
              result_balance[ 1 ]-Balance = result_balance[ 1 ]-Balance + Trans_amt-Amount.
            ENDIF.
          WHEN 'DEBIT'. " Debit: Subtract from balance
            IF ( result_balance[ 1 ]-CurrencyKey  = result_amount[ 1 ]-CurrencyKey  ).
              result_balance[ 1 ]-Balance = result_balance[ 1 ]-Balance - Trans_amt-Amount.
            ENDIF.
        ENDCASE.
      ENDLOOP.
    ELSE.
      result_balance[ 1 ]-Balance = result_balance[ 1 ]-Balance.

    ENDIF.

    MODIFY ENTITIES OF zi_account1
    ENTITY Account
*       UPDATE FIELDS ( Balance )
*    WITH VALUE #( FOR key IN keys
*    ( %key-AccUuid = key-AccUuid
*    Balance = lt_account_u[ 1 ]-Balance ) )
    UPDATE FROM  VALUE #( (  %key-AccUuid = result_balance[ 1 ]-AccUuid
    Balance = result_balance[ 1 ]-Balance
    %control-Balance = if_abap_behv=>mk-on ) )
    FAILED DATA(failed)
    REPORTED DATA(reported1).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD updateAmount.

    MODIFY ENTITIES OF zi_account1 IN LOCAL MODE
      ENTITY Transaction
      UPDATE FIELDS ( Amount CurrencyKey )
      WITH VALUE #( FOR key IN keys
      ( %key-TransUuid = key-TransUuid
      Amount = key-%param-amount
      CurrencyKey = key-%param-currency_key ) )
      REPORTED DATA(report)
      FAILED DATA(fail).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_ACCOUNT1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Account RESULT result.
    METHODS valcreateddate FOR VALIDATE ON SAVE
      IMPORTING keys FOR account~valcreateddate.
    METHODS setzero FOR MODIFY
      IMPORTING keys FOR ACTION account~setzero.
    METHODS updatebalance FOR MODIFY
      IMPORTING keys FOR ACTION account~updatebalance.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR account RESULT result.



ENDCLASS.

CLASS lhc_ZI_ACCOUNT1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD valCreatedDate.

    READ ENTITIES OF zi_account1
    ENTITY  Account
    FIELDS ( DateCreated )
    WITH VALUE #( ( %key-AccUuid = keys[ 1 ]-%key-AccUuid ) )
    RESULT DATA(result).

    LOOP AT result INTO DATA(ls_result).
      IF ls_result-DateCreated < sy-datum OR ls_result-DateCreated > sy-datum.
        failed-account = VALUE #( ( %key-AccUuid = ls_result-%key-AccUuid ) ).
        reported-account = VALUE #( (  %key-AccUuid = ls_result-%key-AccUuid
                                     %msg = new_message_with_text( text = 'Date must be on Date' ) ) ).

      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD setzero.
    DATA: lt_account_u     TYPE TABLE FOR UPDATE zi_account1,
          ls_account_u     LIKE LINE OF lt_account_u,
          lt_transaction_u TYPE TABLE FOR UPDATE zi_transaction1,
          ls_transaction_u LIKE LINE OF lt_transaction_u.
    READ ENTITIES OF zi_account1
      ENTITY  Account
      ALL FIELDS WITH VALUE #( ( %key-AccUuid = keys[ 1 ]-%key-AccUuid ) )
      RESULT DATA(Account)
      ENTITY Account BY \_transaction
      ALL FIELDS WITH VALUE #( ( %key-AccUuid = keys[ 1 ]-%key-AccUuid ) )
      RESULT DATA(Transaction).

    LOOP AT account INTO DATA(ls_acc).
      ls_account_u = CORRESPONDING #( ls_acc ).
      ls_account_u-Balance = 0.
      ls_account_u-%control-Balance = if_abap_behv=>mk-on.
      APPEND ls_account_u TO lt_account_u.
    ENDLOOP.

    LOOP AT transaction INTO DATA(ls_trans).
      ls_transaction_u = CORRESPONDING #( ls_trans ).
      ls_transaction_u-Amount = 0.
      ls_transaction_u-%control-Amount = if_abap_behv=>mk-on.
      APPEND ls_transaction_u TO lt_transaction_u.
    ENDLOOP.

    MODIFY ENTITIES OF zi_account1 IN LOCAL MODE
    ENTITY Account
    UPDATE FIELDS ( Balance )
    WITH VALUE #( FOR key IN keys
    ( %key-AccUuid = key-AccUuid
    Balance = lt_account_u[ 1 ]-Balance ) )
**    UPDATE FROM lt_account_u
    ENTITY Transaction
*    UPDATE FIELDS ( Amount )
*    WITH VALUE #( FOR key IN keys
*    ( AccUuid = key-AccUuid
*    Amount = lt_transaction_u[ 1 ]-Amount ) )
 UPDATE FROM lt_transaction_u
    FAILED DATA(failed1)
    REPORTED DATA(reported1).


  ENDMETHOD.

  METHOD updateBalance.
    MODIFY ENTITIES OF zi_account1 IN LOCAL MODE
  ENTITY Account
  UPDATE FIELDS ( Balance CurrencyKey )
  WITH VALUE #( FOR key IN keys
  ( %key-AccUuid = key-AccUuid
  Balance = key-%param-balance
  CurrencyKey = key-%param-currency_key ) )
  REPORTED DATA(report)
  FAILED DATA(fail).
  ENDMETHOD.

*  METHOD get_global_features.
**  READ ENTITIES OF zi_account1 IN LOCAL MODE
**  ENTITY Account BY \_transaction
**      FIELDS ( TransUuid )
**      WITH VALUE #( %key-AccUuid =  )
**      RESULT DATA(Transaction).
*
*"if ( result-%assoc-_transaction > 5 ).
*
*result-%assoc-_transaction = if_abap_behv=>fc-o-disabled.
*"ENDIF.
* ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_account1 IN LOCAL MODE
   ENTITY Account BY \_transaction
       FIELDS ( TransUuid )
       WITH VALUE #( ( %key-AccUuid = keys[ 1 ]-%key-AccUuid ) )
       RESULT DATA(Transaction).

    DATA: lv_count TYPE i.
*          modify_create TYPE string.

    lv_count = lines( transaction ).

   DATA(modify_create) = COND #( WHEN lv_count EQ 5
    THEN  if_abap_behv=>fc-o-disabled
    ELSE if_abap_behv=>fc-o-enabled ).

    result = VALUE #( ( %tky = keys[ 1 ]-%tky
    %features-%assoc-_transaction = modify_create ) ).

  ENDMETHOD.

ENDCLASS.
