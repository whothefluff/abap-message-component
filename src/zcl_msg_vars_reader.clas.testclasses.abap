*"* use this source file for your ABAP unit test classes

"! Testing {@link .SY_FTY}
class _sy_fty definition
              final
              for testing
              risk level harmless
              duration short.

  private section.

    methods get_rets_instance for testing.

endclass.
class _sy_fty implementation.

  method get_rets_instance.

    "arrange
    final(o) = new sy_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->get( ) ).

  endmethod.

endclass.

class _exc_msg_vars_rdr_r_basic_stub definition ##CLASS_FINAL
                                     inheriting from zcl_msg_vars_reader
                                     create public
                                     for testing.

  public section.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_canned_answer type _exc_msg_vars_rdr_r_basic_stub=>t_canned_answer.

    methods read_basic redefinition.

  protected section.

    data _canned_answer type _exc_msg_vars_rdr_r_basic_stub=>t_canned_answer.

endclass.
class _exc_msg_vars_rdr_r_basic_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method read_basic.

    return _canned_answer.

  endmethod.

endclass.

class _exc_msg_vars_rdr_r_t100_stub definition ##CLASS_FINAL
                                    inheriting from zcl_msg_vars_reader
                                    create public
                                    for testing.

  public section.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_canned_answer type _exc_msg_vars_rdr_r_t100_stub=>t_canned_answer.

    methods read_t100 redefinition.

  protected section.

    data _canned_answer type _exc_msg_vars_rdr_r_t100_stub=>t_canned_answer.

endclass.
class _exc_msg_vars_rdr_r_t100_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method read_t100.

    return _canned_answer.

  endmethod.

endclass.

class _call_tracker definition ##CLASS_FINAL
                    create public
                    for testing.

  public section.

    types t_log type string_table.

    methods register
              importing
                i_call type string.

    data log type _call_tracker=>t_log read-only.

endclass.
class _call_tracker implementation.

  method register.

    log = value #( base log
                   ( i_call ) ).

  endmethod.

endclass.

class _e_msg_vars_rdr_r_sy_spy_stub definition ##CLASS_FINAL
                                    inheriting from zcl_msg_vars_reader
                                    create public
                                    for testing.

  public section.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_canned_answer type _e_msg_vars_rdr_r_sy_spy_stub=>t_canned_answer
                i_tracker type ref to _call_tracker.

    methods read_system redefinition.

  protected section.

    data _tracker type ref to _call_tracker.

    data _canned_answer type _e_msg_vars_rdr_r_sy_spy_stub=>t_canned_answer.

endclass.
class _e_msg_vars_rdr_r_sy_spy_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

    _tracker = i_tracker.

  endmethod.
  method read_system.

    _tracker->register( `READ_SYSTEM` ).

    return _canned_answer.

  endmethod.

endclass.

class _msg_helper_wrapper_set_sy_spy definition ##CLASS_FINAL
                                     inheriting from msg_helper_wrapper
                                     create public
                                     for testing.

  public section.

    methods constructor
              importing
                i_tracker type ref to _call_tracker.

    methods set_sy_msg_vars_with redefinition.

  protected section.

    data _tracker type ref to _call_tracker.

endclass.
class _msg_helper_wrapper_set_sy_spy implementation.

  method constructor.

    super->constructor( ).

    _tracker = i_tracker.

  endmethod.
  method set_sy_msg_vars_with.

    _tracker->register( `SET_SY_MSG_VARS_WITH` ).

  endmethod.

endclass.

class _exc_msg_vars_rdr_r_t1dyn_stub definition ##CLASS_FINAL
                                     inheriting from zcl_msg_vars_reader
                                     create public
                                     for testing.

  public section.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_canned_answer type _exc_msg_vars_rdr_r_t1dyn_stub=>t_canned_answer.

    methods read_t100_dyn redefinition.

  protected section.

    data _canned_answer type _exc_msg_vars_rdr_r_t1dyn_stub=>t_canned_answer.

endclass.
class _exc_msg_vars_rdr_r_t1dyn_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method read_t100_dyn.

    return _canned_answer.

  endmethod.

endclass.

class _msg_hlpr_wrppr_msg_vars_stub definition ##CLASS_FINAL
                                    inheriting from msg_helper_wrapper
                                    create public
                                    for testing.

  public section.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_canned_answer type _msg_hlpr_wrppr_msg_vars_stub=>t_canned_answer.

    methods msg_vars_of redefinition.

  protected section.

    data _canned_answer type _msg_hlpr_wrppr_msg_vars_stub=>t_canned_answer.

endclass.
class _msg_hlpr_wrppr_msg_vars_stub implementation.

  method constructor.

    super->constructor( ).

    _canned_answer = i_canned_answer.

  endmethod.
  method msg_vars_of.

    return _canned_answer.

  endmethod.

endclass.

class _exc_msg_vars_rdr_r_behv_stub definition ##CLASS_FINAL
                                    inheriting from zcl_msg_vars_reader
                                    create public
                                    for testing.

  public section.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_canned_answer type _exc_msg_vars_rdr_r_behv_stub=>t_canned_answer.

    methods read_behv redefinition.

  protected section.

    data _canned_answer type _exc_msg_vars_rdr_r_behv_stub=>t_canned_answer.

endclass.
class _exc_msg_vars_rdr_r_behv_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method read_behv.

    return _canned_answer.

  endmethod.

endclass.

class _xco_message_value_stub definition ##CLASS_FINAL
                              create public
                              for testing.

  public section.

    interfaces if_xco_message partially implemented.

    aliases: value for if_xco_message~value.

    methods constructor
              importing
                i_value type symsg.

endclass.
class _xco_message_value_stub implementation.

  method constructor.

    value = i_value.

  endmethod.

endclass.

class _ definition deferred.

class zcl_msg_vars_reader definition local friends _.

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

    methods safe_read_valid_msg for testing.

    methods safe_read_invalid_msg for testing.

    methods read_basic_delegates_to_downct for testing.

    methods read_basic_defaults for testing.

    methods read_t100_delegates_to_downct for testing.

    methods read_t100_defaults for testing.

    methods read_dyn_delegates_to_downct for testing.

    methods read_dyn_defaults for testing.

    methods read_behv_with_severity for testing.

    methods read_behv_without_severity for testing.

    methods read_system_uses_msg_n_clean_t for testing.

    class-methods class_teardown.

    class-data _msg_helper_wrapper_backup type ref to msg_helper_wrapper.

    class-data _sy_fty_backup type ref to sy_fty.

endclass.
class _ implementation.

  method class_setup.

    _msg_helper_wrapper_backup = cast #( zcl_msg_vars_reader=>_msg_helper_wrapper ).

    _sy_fty_backup = cast #( zcl_msg_vars_reader=>_sy_fty ).

  endmethod.
  method setup.

    zcl_msg_vars_reader=>_msg_helper_wrapper = _msg_helper_wrapper_backup.

    zcl_msg_vars_reader=>_sy_fty = _sy_fty_backup.

  endmethod.
  method constructor_sets_attr.

    "ararange
    final(some_t_s) = new zcl_msg_type_severity_pairs( ).

    "act
    final(o) = new zcl_msg_vars_reader( some_t_s ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_type_severities eq some_t_s
                                               and o->_msg_helper_wrapper is bound
                                               and o->_sy_fty is bound ) ).

  endmethod.
  method safe_read_valid_msg.

    "arrange
    final(some_msg_vars) = value symsg( msgv1 = 'm' ).

    final(o) = new _exc_msg_vars_rdr_r_basic_stub( some_msg_vars ).

    final(some_msg) = cast if_message( cl_abap_testdouble=>create( 'IF_MESSAGE' ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_msg_vars
                                        act = o->safe_read( i_msg = some_msg
                                                            i_fallback = value #( msgv1 = 'o' ) ) ).

  endmethod.
  method safe_read_invalid_msg.

    "arrange
    final(o) = new zcl_msg_vars_reader( value #( ) ).

    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(some_t_s_type) = 'Z'.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( some_t_s_type ).

    final(some_fb) = value symsg( msgv1 = 'm' ).

    some_t_s->clean_type( some_fb-msgty ).

    o->_type_severities = some_t_s.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( msgid = some_fb-msgid
                                                           msgno = some_fb-msgno
                                                           msgty = some_t_s_type
                                                           msgv1 = some_fb-msgv1
                                                           msgv2 = some_fb-msgv2
                                                           msgv3 = some_fb-msgv3
                                                           msgv4 = some_fb-msgv4 )
                                        act = o->safe_read( i_msg = value #( )
                                                            i_fallback = some_fb ) ).

  endmethod.
  method read_basic_delegates_to_downct.

    "arrange
    final(some_msg_vars) = value symsg( msgv1 = 't' ).

    final(o) = new _exc_msg_vars_rdr_r_t100_stub( some_msg_vars ).

    final(some_t100_msg) = cast if_t100_message( cl_abap_testdouble=>create( 'IF_T100_MESSAGE' ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_msg_vars
                                        act = o->read_basic( some_t100_msg ) ).

  endmethod.
  method read_basic_defaults.

    "arrange
    final(tracker) = new _call_tracker( ).

    final(some_sys_msg) = value symsg( msgid = 's'
                                       msgno = '1' ).

    final(o) = cast zcl_msg_vars_reader( new _e_msg_vars_rdr_r_sy_spy_stub( i_canned_answer = some_sys_msg
                                                                            i_tracker = tracker ) ).

    final(some_msg_hpr_wrapper) = new _msg_helper_wrapper_set_sy_spy( tracker ).

    o->_msg_helper_wrapper = some_msg_hpr_wrapper.

    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(some_t_s_type) = 'Z'.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( some_t_s_type ).

    some_t_s->clean_type( value #( ) ).

    o->_type_severities = some_t_s.

    final(some_msg) = cast if_message( cl_abap_testdouble=>create( 'IF_MESSAGE' ) ).

    "act
    final(act_msg) = o->read_basic( some_msg ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( act_msg eq value symsg( base some_sys_msg
                                                                       msgty = some_t_s_type )
                                               and tracker->log eq value string_table( ( `SET_SY_MSG_VARS_WITH` )
                                                                                       ( `READ_SYSTEM` ) ) ) ).

  endmethod.
  method read_t100_delegates_to_downct.

    "arrange
    final(some_msg_vars) = value symsg( msgv1 = 'd' ).

    final(o) = new _exc_msg_vars_rdr_r_t1dyn_stub( some_msg_vars ).

    final(some_t100_dyn_msg) = cast if_t100_dyn_msg( cl_abap_testdouble=>create( 'IF_T100_DYN_MSG' ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_msg_vars
                                        act = o->read_t100( some_t100_dyn_msg ) ).

  endmethod.
  method read_t100_defaults.

    "arrange
    final(some_msg_vars) = value symsg( msgv1 = 'w' ).

    final(o) = new zcl_msg_vars_reader( value #( ) ).

    o->_msg_helper_wrapper = new _msg_hlpr_wrppr_msg_vars_stub( some_msg_vars ).

    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(some_t_s_type) = 'Z'.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( some_t_s_type ).

    some_t_s->clean_type( value #( ) ).

    o->_type_severities = some_t_s.

    final(some_t100_msg) = cast if_t100_message( cl_abap_testdouble=>create( 'IF_T100_MESSAGE' ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( base some_msg_vars
                                                           msgty = some_t_s_type )
                                        act = o->read_t100( some_t100_msg ) ).

  endmethod.
  method read_dyn_delegates_to_downct.

    "arrange
    final(some_msg_vars) = value symsg( msgv1 = 'b' ).

    final(o) = new _exc_msg_vars_rdr_r_behv_stub( some_msg_vars ).

    final(some_behv_msg) = cast if_abap_behv_message( cl_abap_testdouble=>create( 'IF_ABAP_BEHV_MESSAGE' ) ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_msg_vars
                                        act = o->read_t100_dyn( some_behv_msg ) ).

  endmethod.
  method read_dyn_defaults.

    "arrange
    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(cleaned_type) = 'Z'.

    final(raw_type) = 'A'.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( cleaned_type ).

    some_t_s->clean_type( raw_type ).

    final(some_msg) = cast if_t100_dyn_msg( cl_abap_testdouble=>create( 'IF_T100_DYN_MSG' ) ).

    some_msg->if_t100_message~t100key = value #( msgid = 'TEST'
                                                 msgno = 123 ).

    some_msg->msgty = raw_type.

    some_msg->msgv1 = '1'.

    some_msg->msgv2 = '2'.

    some_msg->msgv3 = '3'.

    some_msg->msgv4 = '4'.

    final(o) = new zcl_msg_vars_reader( value #( ) ).

    o->_type_severities = some_t_s.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( msgid = 'TEST'
                                                           msgno = 123
                                                           msgty = cleaned_type
                                                           msgv1 = '1'
                                                           msgv2 = '2'
                                                           msgv3 = '3'
                                                           msgv4 = '4' )
                                        act = o->read_t100_dyn( some_msg ) ).

  endmethod.
  method read_behv_with_severity.

    "arrange
    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(mapped_type) = 'Z'.

    final(raw_severity) = if_abap_behv_message=>severity-error.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( mapped_type ).

    some_t_s->type_of( raw_severity ).

    final(some_msg) = cast if_abap_behv_message( cl_abap_testdouble=>create( 'IF_ABAP_BEHV_MESSAGE' ) ).

    some_msg->m_severity = raw_severity.

    some_msg->if_t100_message~t100key = value #( msgid = 'BEHV'
                                                 msgno = 111 ).

    some_msg->if_t100_dyn_msg~msgv1 = '1'.

    some_msg->if_t100_dyn_msg~msgv2 = '2'.

    some_msg->if_t100_dyn_msg~msgv3 = '3'.

    some_msg->if_t100_dyn_msg~msgv4 = '4'.

    final(o) = new zcl_msg_vars_reader( value #( ) ).

    o->_type_severities = some_t_s.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( msgid = 'BEHV'
                                                           msgno = 111
                                                           msgty = mapped_type
                                                           msgv1 = '1'
                                                           msgv2 = '2'
                                                           msgv3 = '3'
                                                           msgv4 = '4' )
                                        act = o->read_behv( some_msg ) ).

  endmethod.
  method read_behv_without_severity.

    "arrange
    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(cleaned_type) = 'Z'.

    final(raw_type) = 'A'.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( cleaned_type ).

    some_t_s->clean_type( raw_type ).

    final(some_msg) = cast if_abap_behv_message( cl_abap_testdouble=>create( 'IF_ABAP_BEHV_MESSAGE' ) ).

    some_msg->if_t100_dyn_msg~msgty = raw_type.

    some_msg->if_t100_message~t100key = value #( msgid = 'DEF'
                                                 msgno = 222 ).

    some_msg->if_t100_dyn_msg~msgv1 = 'A'.

    some_msg->if_t100_dyn_msg~msgv2 = 'B'.

    some_msg->if_t100_dyn_msg~msgv3 = 'C'.

    some_msg->if_t100_dyn_msg~msgv4 = 'D'.

    final(o) = new zcl_msg_vars_reader( value #( ) ).

    o->_type_severities = some_t_s.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( msgid = 'DEF'
                                                           msgno = 222
                                                           msgty = cleaned_type
                                                           msgv1 = 'A'
                                                           msgv2 = 'B'
                                                           msgv3 = 'C'
                                                           msgv4 = 'D' )
                                        act = o->read_behv( some_msg ) ).

  endmethod.
  method read_system_uses_msg_n_clean_t.

    "arrange
    final(some_t_s) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    final(cleaned_type) = 'Z'.

    final(raw_type) = 'A'.

    cl_abap_testdouble=>configure_call( some_t_s )->returning( cleaned_type ).

    some_t_s->clean_type( raw_type ).

    final(some_sy_msg_v) = value symsg( msgid = 'SYS'
                                        msgno = 001
                                        msgty = raw_type
                                        msgv1 = 'A'
                                        msgv2 = 'B' ).

    final(some_sy_msg) = new _xco_message_value_stub( some_sy_msg_v ).

    final(some_sy) = cast if_xco_cp_std_sy( cl_abap_testdouble=>create( 'IF_XCO_CP_STD_SY' ) ).

    cl_abap_testdouble=>configure_call( some_sy )->returning( some_sy_msg ).

    some_sy->message( ).

    final(o) = new zcl_msg_vars_reader( value #( ) ).

    o->_type_severities = some_t_s.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = value symsg( msgid = some_sy_msg_v-msgid
                                                           msgno = some_sy_msg_v-msgno
                                                           msgty = cleaned_type
                                                           msgv1 = some_sy_msg_v-msgv1
                                                           msgv2 = some_sy_msg_v-msgv2
                                                           msgv3 = some_sy_msg_v-msgv3
                                                           msgv4 = some_sy_msg_v-msgv4 )
                                        act = o->read_system( some_sy ) ).

  endmethod.
  method class_teardown.

    zcl_msg_vars_reader=>_msg_helper_wrapper = _msg_helper_wrapper_backup.

    zcl_msg_vars_reader=>_sy_fty = _sy_fty_backup.

  endmethod.

endclass.
