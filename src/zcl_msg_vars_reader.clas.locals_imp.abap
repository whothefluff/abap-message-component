*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

"! Wraps un-mockable behavior
class msg_helper_wrapper definition ##CLASS_FINAL
                         create public.

  public section.

    "! Sets no type at all. Un-testable with unit tests
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    methods set_sy_msg_vars_with
              importing
                i_msg type ref to if_message.

    "! Type error hard-coded in the implementation
    "!
    "! @parameter i_msg | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods msg_vars_of
              importing
                i_msg type ref to if_t100_message
              returning
                value(r_val) type symsg.

endclass.
class msg_helper_wrapper implementation.

  method set_sy_msg_vars_with.

    cl_message_helper=>set_msg_vars_for_if_msg( i_msg ).

  endmethod.
  method msg_vars_of.

    return cl_message_helper=>get_t100_for_object( i_msg ).

  endmethod.

endclass.

"! Wraps un-mockable behavior
class sy_fty definition ##CLASS_FINAL
             create public.

  public section.

    methods get
              returning
                value(r_val) type ref to if_xco_cp_std_sy.

endclass.
class sy_fty implementation.

  method get.

    return xco_cp=>sy.

  endmethod.

endclass.
