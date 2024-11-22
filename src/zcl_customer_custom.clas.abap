CLASS zcl_customer_custom DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CUSTOMER_CUSTOM IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

  IF io_request->is_data_requested( ).

      DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
      IF lv_top < 0.
        lv_top = 1.
      ENDIF.

      DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

      DATA(lt_sort)    = io_request->get_sort_elements( ).

      DATA : lv_orderby TYPE string.
      LOOP AT lt_sort INTO DATA(ls_sort).
        IF ls_sort-descending = abap_true.
          lv_orderby = |'{ lv_orderby } { ls_sort-element_name } DESCENDING '|.
        ELSE.
          lv_orderby = |'{ lv_orderby } { ls_sort-element_name } ASCENDING '|.
        ENDIF.
      ENDLOOP.
      IF lv_orderby IS INITIAL.
        lv_orderby = 'CUSTOMER_ID'.
      ENDIF.

      DATA(lv_conditions) =  io_request->get_filter( )->get_as_sql_string( ).

      SELECT FROM znb_customer
        FIELDS customer_id , name, address , email, contact, date_of_birth
        WHERE (lv_conditions)
        ORDER BY (lv_orderby)
        INTO TABLE @DATA(customers)
        UP TO @lv_top ROWS OFFSET @lv_skip.

      IF io_request->is_total_numb_of_rec_requested(  ).
        io_response->set_total_number_of_records( lines( customers ) ).
        io_response->set_data( customers ).
      ENDIF.

    ENDIF.
    ENDMETHOD.
ENDCLASS.
