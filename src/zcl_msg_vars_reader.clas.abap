"! <p class="shorttext synchronized" lang="EN">Message Variables Reader</p>
class zcl_msg_vars_reader definition
                          public
                          create public.

  public section.

    types:
           "! <p class="shorttext synchronized" lang="EN"></p>
           t_type_severities type ref to zcl_msg_type_severity_pairs.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_type_severities | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_type_severities type zcl_msg_vars_reader=>t_type_severities.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_fallback | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods safe_read
              importing
                i_msg type ref to if_message
                i_fallback type symsg
              returning
                value(r_val) type symsg.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods read_basic
              importing
                i_msg type ref to if_message
              returning
                value(r_val) type symsg.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods read_t100
              importing
                i_msg type ref to if_t100_message
              returning
                value(r_val) type symsg.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods read_t100_dyn
              importing
                i_msg type ref to if_t100_dyn_msg
              returning
                value(r_val) type symsg.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods read_behv
              importing
                i_msg type ref to if_abap_behv_message
              returning
                value(r_val) type symsg.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_ref | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods read_system
              importing
                i_ref type ref to if_xco_cp_std_sy
              returning
                value(r_val) type symsg.

  protected section.

    data _type_severities type zcl_msg_vars_reader=>t_type_severities.

    class-data _sy_fty type ref to object.

    class-data _msg_helper_wrapper type ref to object.

endclass.
class zcl_msg_vars_reader implementation.

  method class_constructor.

    _sy_fty = new sy_fty( ).

    _msg_helper_wrapper = new msg_helper_wrapper( ).

  endmethod.
  method constructor.

    _type_severities = i_type_severities.

  endmethod.
  method safe_read.

    return cond #( when i_msg is bound
                   then read_basic( i_msg )
                   else value #( base i_fallback
                                 msgty = _type_severities->clean_type( i_fallback-msgty ) ) ).

  endmethod.
  method read_basic.

    data(msg) = value symsg( ).

    try.

      msg = read_t100( cast #( i_msg ) ).

    catch cx_sy_move_cast_error.

      cast msg_helper_wrapper( _msg_helper_wrapper )->set_sy_msg_vars_with( i_msg ). "sets no type

      msg = value #( base read_system( cast sy_fty( _sy_fty )->get( ) )
                     msgty = _type_severities->clean_type( value #( ) ) ). "force default

    endtry.

    return msg.

  endmethod.
  method read_t100.

    data(msg) = value symsg( ).

    try.

      msg = read_t100_dyn( cast #( i_msg ) ).

    catch cx_sy_move_cast_error.

      msg = value #( base cast msg_helper_wrapper( _msg_helper_wrapper )->msg_vars_of( i_msg ) "always returns type Error
                     msgty = _type_severities->clean_type( value #( ) ) ). "replace hard-coded value with default type

    endtry.

    return msg.

  endmethod.
  method read_t100_dyn.

    data(msg) = value symsg( ).

    try.

      msg = read_behv( cast #( i_msg ) ).

    catch cx_sy_move_cast_error.

      msg = value #( msgty = _type_severities->clean_type( i_msg->msgty )
                     msgid = i_msg->if_t100_message~t100key-msgid
                     msgno = i_msg->if_t100_message~t100key-msgno
                     msgv1 = i_msg->msgv1
                     msgv2 = i_msg->msgv2
                     msgv3 = i_msg->msgv3
                     msgv4 = i_msg->msgv4 ).

    endtry.

    return msg.

  endmethod.
  method read_behv.

    return value #( msgty = cond #( when i_msg->m_severity is not initial
                                    then _type_severities->type_of( i_msg->m_severity )
                                    else _type_severities->clean_type( i_msg->if_t100_dyn_msg~msgty ) )
                    msgid = i_msg->if_t100_message~t100key-msgid
                    msgno = i_msg->if_t100_message~t100key-msgno
                    msgv1 = i_msg->if_t100_dyn_msg~msgv1
                    msgv2 = i_msg->if_t100_dyn_msg~msgv2
                    msgv3 = i_msg->if_t100_dyn_msg~msgv3
                    msgv4 = i_msg->if_t100_dyn_msg~msgv4 ).

  endmethod.
  method read_system.

    return value #( let sy_msg = i_ref->message( )->value in
                    base sy_msg
                    msgty = _type_severities->clean_type( sy_msg-msgty ) ).

  endmethod.

endclass.
