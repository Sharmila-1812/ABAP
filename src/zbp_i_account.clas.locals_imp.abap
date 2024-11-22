CLASS lhc_Account DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Account RESULT result.
    METHODS valcreateddate FOR VALIDATE ON SAVE
      IMPORTING keys FOR account~valcreateddate.
    METHODS earlynumbering_cba_transaction FOR NUMBERING
      IMPORTING entities FOR CREATE account\_transaction.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE account.
ENDCLASS.

CLASS lhc_Account IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
  DATA: Acc_id_max TYPE znb_account-account_id,
        lv_next_id TYPE znb_account-account_id.
*       lv_next_id = '000'.
  SELECT SINGLE FROM znb_account FIELDS MAX( account_id ) INTO @Acc_id_max.
  IF Acc_id_max IS NOT INITIAL.
    lv_next_id = acc_id_max + 1.
  ELSE.
    lv_next_id = '001'.
  ENDIF.
  LOOP AT entities INTO DATA(entity).
  mapped-account = VALUE #( ( %cid = entity-%cid
   AccountId = lv_next_id  ) ).
  ENDLOOP.
  ENDMETHOD.

  METHOD earlynumbering_cba_Transaction.
   DATA: Trans_id_max TYPE znb_transactn-transaction_id,
        lv_next_id1 TYPE znb_transactn-transaction_id.
  SELECT SINGLE FROM znb_transactn FIELDS MAX( transaction_id ) INTO @Trans_id_max.
  IF Trans_id_max IS NOT INITIAL.
    lv_next_id1 = Trans_id_max + 1.
  ELSE.
    lv_next_id1 = 1.
  ENDIF.
  LOOP AT entities INTO DATA(entity).
  mapped-transaction = VALUE #( ( %cid = entity-%cid_ref
   TransactionId = lv_next_id1 ) ).
  ENDLOOP.
  ENDMETHOD.

  METHOD valCreatedDate.

  READ ENTITIES OF zi_account
  ENTITY  Account
  FIELDS ( DateCreated )
  WITH VALUE #( ( %key-AccountId = keys[ 1 ]-%key-AccountId ) )
  RESULT DATA(result).

  LOOP AT result INTO DATA(ls_result).
  if ls_result-DateCreated < sy-datum or ls_result-DateCreated > sy-datum.
   failed-account = VALUE #( ( %key-AccountId = ls_result-%key-AccountId ) ).
   reported-account = VALUE #( (  %key-AccountId = ls_result-%key-AccountId
                                %msg = new_message_with_text( text = 'Date must be on Date' ) ) ).
   ENDIF.

  ENDLOOP.
  ENDMETHOD.

ENDCLASS.
