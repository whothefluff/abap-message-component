"! <p class="shorttext synchronized" lang="EN">Type-severity Relationships</p>
"!
"! <p>
"! Asymmetric mapping that represents the link between a type or severity
"! and it's Cloud Platform compatible counterpart
"! </p>
class zcl_msg_type_severity_pairs definition
                                  public
                                  create public.

  public section.

    types:
           "! <p class="shorttext synchronized" lang="EN"></p>
           begin of t_map_entry,
             type type symsgty,
             severity type if_abap_behv_message=>t_severity,
           end of t_map_entry.

    class-methods class_constructor.

    methods constructor
              importing
                i_severity_of_default type zcl_msg_type_severity_pairs=>t_map_entry-severity optional
                i_type_of_default type zcl_msg_type_severity_pairs=>t_map_entry-type optional.

    "! <p class="shorttext synchronized" lang="EN">Returns a valid Severity for a type. Defaults to Error</p>
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods severity_of
              importing
                i_type type zcl_msg_type_severity_pairs=>t_map_entry-type
              returning
                value(r_val) type zcl_msg_type_severity_pairs=>t_map_entry-severity.

    "! <p class="shorttext synchronized" lang="EN">Returns a valid type for a Severity. Defaults to Error</p>
    "!
    "! @parameter i_severity | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods type_of
              importing
                i_severity type zcl_msg_type_severity_pairs=>t_map_entry-severity
              returning
                value(r_val) type zcl_msg_type_severity_pairs=>t_map_entry-type.

    "! <p class="shorttext synchronized" lang="EN">Returns the argument if valid, otherwise returns Error</p>
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods clean_type
              importing
                i_type type zcl_msg_type_severity_pairs=>t_map_entry-type
              returning
                value(r_val) type zcl_msg_type_severity_pairs=>t_map_entry-type.

  protected section.

    types: _t_map type hashed table of zcl_msg_type_severity_pairs=>t_map_entry with unique key type
                                                                                with non-unique sorted key by_sev components severity,
           _t_cp_map type hashed table of zcl_msg_type_severity_pairs=>t_map_entry with unique key type
                                                                                   with unique hashed key by_sev components severity.

    data _severity_of_default type zcl_msg_type_severity_pairs=>t_map_entry-severity.

    data _type_of_default type zcl_msg_type_severity_pairs=>t_map_entry-type.

    class-data _map type zcl_msg_type_severity_pairs=>_t_map.

    class-data _cp_map type zcl_msg_type_severity_pairs=>_t_cp_map.

endclass.
class zcl_msg_type_severity_pairs implementation.

  method constructor.

    _severity_of_default = i_severity_of_default.

    _type_of_default = i_type_of_default.

  endmethod.
  method class_constructor.

    types: begin of enum old_type structure old_types base type c,
             termination value 'A',
             exit value 'X',
             null value is initial,
           end of enum old_type structure old_types.

    _map = value #( ( lines of value #( severity = if_abap_behv_message=>severity-error
                                        ( type = xco_cp_message=>type->error->value )
                                        ( type = conv #( old_types-exit ) )
                                        ( type = conv #( old_types-termination ) ) ) )
                    ( type = xco_cp_message=>type->warning->value
                      severity = if_abap_behv_message=>severity-warning )
                    ( type = xco_cp_message=>type->information->value
                      severity = if_abap_behv_message=>severity-information )
                    ( type = xco_cp_message=>type->success->value
                      severity = if_abap_behv_message=>severity-success ) ).

    _cp_map = filter #( filter _t_map( _map except where type eq conv #( old_types-exit ) ) except where type eq conv #( old_types-termination ) ).

  endmethod.
  method severity_of.

    return value #( _map[ type = i_type ]-severity
                    default _severity_of_default ).

  endmethod.
  method type_of.

    return value #( _cp_map[ key by_sev
                             severity = i_severity ]-type
                    default _type_of_default ).

  endmethod.
  method clean_type.

    return type_of( severity_of( i_type ) ).

  endmethod.

endclass.
