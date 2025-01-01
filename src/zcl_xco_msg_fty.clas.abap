"! <p class="shorttext synchronized" lang="EN">XCO Message Factory</p>
"!
"! Wraps un-mockable behavior
class zcl_xco_msg_fty definition
                      public
                      create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Returns a new message</p>
    "!
    "! @parameter i_vars | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods for
              importing
                i_vars type symsg
              returning
                value(r_val) type ref to if_xco_message.

  protected section.

endclass.
class zcl_xco_msg_fty implementation.

  method for.

    return xco_cp=>message( i_vars ).

  endmethod.

endclass.
