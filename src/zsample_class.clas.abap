CLASS zsample_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSAMPLE_CLASS IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

* DATA: ls_customer TYPE TABLE of znb_customer.
UPDATE znb_customer SET date_of_birth = '20120622' WHERE customer_id = '3'.
*       ls_customer = VALUE #( (   customer_id = '4'
*       name = 'Customer-4'
*       address = 'TamilNadu'
*       contact = '9875642215'
*       email = 'cust4@gmail.com'
*       date_of_birth = '20001218' ) ).
*       INSERT znb_customer FROM TABLE @ls_customer.

*DATA: ls_acc TYPE TABLE of znb_account.
*      UPDATE znb_account SET date_created = '20021112' WHERE account_id = '004'.
**       ls_acc = VALUE #( (   account_id = '004'
**       customer_id = '5'
**       account_type = 'SAVINGS'
**       balance = '5102.00'
**       currency_key = 'INR'
**       date_created = '20241023' ) ).
**       INSERT znb_account FROM TABLE @ls_acc.
*DATA: ls_trans TYPE TABLE of znb_transactn.
* UPDATE znb_transactn SET trans_date = '20200115'.
*       ls_trans = VALUE #( (  transaction_id = '0003'
*       account_id = '002'
*       transaction_type = 'DEBIT'
*       amount = '800'
*       currency_key = 'INR'
*       trans_date = '12082020'
*       description = 'Amount Debited'
*       ) ).
*       INSERT znb_transactn FROM TABLE @ls_trans.
       ENDMETHOD.
ENDCLASS.
