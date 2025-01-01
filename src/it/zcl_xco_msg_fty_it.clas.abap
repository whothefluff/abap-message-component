"! <p class="shorttext synchronized" lang="EN">XCO Message Factory - Integration tests</p>
"!
"! @testing ZCL_XCO_MSG_FTY
class zcl_xco_msg_fty_it definition
                         public
                         create private
                         for testing
                         risk level harmless
                         duration short.

  public section.

    methods for_rets_inst for testing.

  protected section.

endclass.
class zcl_xco_msg_fty_it implementation.

  method for_rets_inst.

    "arrange
    final(o) = new zcl_xco_msg_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->for( value #( ) ) ).

  endmethod.

endclass.
