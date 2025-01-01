*"* use this source file for your ABAP unit test classes

class _typ_sev_pairs_stub definition ##CLASS_FINAL
                          inheriting from zcl_msg_type_severity_pairs
                          create public
                          for testing.

  public section.

    types: begin of t_severity_of,
             expected type zcl_msg_type_severity_pairs=>t_map_entry-type,
             canned type zcl_msg_type_severity_pairs=>t_map_entry-severity,
           end of t_severity_of.

    types: begin of t_type_of,
             expected type zcl_msg_type_severity_pairs=>t_map_entry-severity,
             canned type zcl_msg_type_severity_pairs=>t_map_entry-type,
           end of t_type_of.

    methods constructor
              importing
                i_severity_of type _typ_sev_pairs_stub=>t_severity_of
                i_type_of type _typ_sev_pairs_stub=>t_type_of.

    methods severity_of redefinition.

    methods type_of redefinition.

  protected section.

    data _severity_of type _typ_sev_pairs_stub=>t_severity_of.

    data _type_of type _typ_sev_pairs_stub=>t_type_of.

endclass.
class _typ_sev_pairs_stub implementation.

  method constructor.

    super->constructor( ).

    _severity_of = i_severity_of.

    _type_of = i_type_of.

  endmethod.
  method severity_of.

    return cond #( when i_type eq _severity_of-expected
                   then _severity_of-canned ).

  endmethod.
  method type_of.

    return cond #( when i_severity eq _type_of-expected
                   then _type_of-canned ).

  endmethod.

endclass.

class _ definition deferred.

class zcl_msg_type_severity_pairs definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    class-methods class_setup.

    methods setup.

    methods constructor_sets_attr for testing.

    methods severity_of_finds for testing.

    methods severity_of_defaults for testing.

    methods type_of_finds for testing.

    methods type_of_defaults for testing.

    methods clean_type_delegates for testing.

    class-methods class_teardown.

    class-data _map_backup type zcl_msg_type_severity_pairs=>_t_map.

    class-data _cp_map_backup type zcl_msg_type_severity_pairs=>_t_cp_map.

endclass.
class _ implementation.

  method class_setup.

    _map_backup = zcl_msg_type_severity_pairs=>_map.

    _cp_map_backup = zcl_msg_type_severity_pairs=>_cp_map.

  endmethod.
  method setup.

    zcl_msg_type_severity_pairs=>_map = _map_backup.

    zcl_msg_type_severity_pairs=>_cp_map = _cp_map_backup.

  endmethod.
  method constructor_sets_attr.

    "arrange
    final(t) = conv zcl_msg_type_severity_pairs=>t_map_entry-type( `Z` ).

    final(s) = if_abap_behv_message=>severity-warning.

    "act
    final(o) = new zcl_msg_type_severity_pairs( i_severity_of_default = s
                                                i_type_of_default = t ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_cp_map is not initial
                                               and o->_map is not initial
                                               and o->_severity_of_default eq s
                                               and o->_type_of_default eq t ) ).

  endmethod.
  method severity_of_finds.

    "arrange
    final(expected_severity) = if_abap_behv_message=>severity-information.

    zcl_msg_type_severity_pairs=>_map = value #( ( type = 'Z'
                                                   severity = expected_severity ) ).

    final(o) = new zcl_msg_type_severity_pairs( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = expected_severity
                                        act = o->severity_of( 'Z' ) ).

  endmethod.
  method severity_of_defaults.

    "arrange
    zcl_msg_type_severity_pairs=>_map = value #( ).

    final(o) = new zcl_msg_type_severity_pairs( ).

    final(d) = if_abap_behv_message=>severity-warning.

    o->_severity_of_default = d.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = d
                                        act = o->severity_of( 'Z' ) ).

  endmethod.
  method type_of_finds.

    "arrange
    final(expected_type) = 'Y'.

    zcl_msg_type_severity_pairs=>_cp_map = value #( ( type = expected_type
                                                      severity = if_abap_behv_message=>severity-warning ) ).

    final(o) = new zcl_msg_type_severity_pairs( ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = expected_type
                                        act = o->type_of( if_abap_behv_message=>severity-warning ) ).

  endmethod.
  method type_of_defaults.

    "arrange
    zcl_msg_type_severity_pairs=>_cp_map = value #( ).

    final(o) = new zcl_msg_type_severity_pairs( ).

    final(d) = conv zcl_msg_type_severity_pairs=>t_map_entry-type( `Z` ).

    o->_type_of_default = d.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = d
                                        act = o->type_of( if_abap_behv_message=>severity-warning ) ).

  endmethod.
  method clean_type_delegates.

    "arrange
    final(input_type) = 'A'.

    final(some_severity) = if_abap_behv_message=>severity-information.

    final(final_type) = 'B'.

    final(o) = new _typ_sev_pairs_stub( i_severity_of = value #( expected = input_type
                                                                 canned = some_severity )
                                        i_type_of = value #( expected = some_severity
                                                             canned = final_type ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = final_type
                                        act = o->clean_type( input_type ) ).

  endmethod.
  method class_teardown.

    zcl_msg_type_severity_pairs=>_map = _map_backup.

    zcl_msg_type_severity_pairs=>_cp_map = _cp_map_backup.

  endmethod.

endclass.
