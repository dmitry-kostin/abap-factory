*&---------------------------------------------------------------------*
*& Report  Z_HELLO_FACTORY
*&
*&---------------------------------------------------------------------*
*& Abstract Factory
*&
*&---------------------------------------------------------------------*

REPORT  Z_HELLO_FACTORY.

class product definition abstract.
  public section.
    data: property type string.
    methods:
      get_type,
      get_property.
endclass.

class product implementation.
  method get_type.
  endmethod.
  method get_property.
    if me->property is initial.
      me->property = 'Empty property'.
    endif.
    write: me->property.
  endmethod.
endclass.

class concrete_product_A definition inheriting from product.
  public section.
  methods get_type redefinition.
endclass.

class concrete_product_A implementation.
  method get_type.
    write: / 'Im product A'.
  endmethod.
endclass.

class concrete_product_B definition inheriting from product.
  public section.
  methods get_type redefinition.
endclass.

class concrete_product_b implementation.
  method get_type.
    write: / 'Im product B'.
  endmethod.
endclass.

class creator definition abstract.
  public section.
  methods: factoryMethod returning value(obj) type ref to product.
endclass.

class creator implementation.
  method factoryMethod.
  endmethod.
endclass.

class concrete_creator_A definition inheriting from creator.
  public section.
  methods factoryMethod redefinition.
endclass.

class concrete_creator_A implementation.
  method factoryMethod.
    data instance type ref to concrete_product_A.
    create object instance.
    obj = instance.
  endmethod.
endclass.

class concrete_creator_B definition inheriting from creator.
  public section.
  methods factoryMethod redefinition.
endclass.

class concrete_creator_B implementation.
  method factoryMethod.
    data instance type ref to concrete_product_B.
    create object instance.
    instance->property = 'concrete_creator_B'.
    obj = instance.
  endmethod.
endclass.


data: creator type ref to creator,
      creator_a type ref to concrete_creator_a,
      creator_b type ref to concrete_creator_b.


start-of-selection.

create object creator_a.
create object creator_b.

types: begin of t_line ,
  instance type ref to product,
  end of t_line.

data: t_creators type standard table of t_line with header line.


t_creators-instance = creator_a->factorymethod( ).
append t_creators.

t_creators-instance = creator_b->factorymethod( ).
append t_creators.


loop at t_creators.
  t_creators-instance->get_type( ).
  t_creators-instance->get_property( ).
endloop.
