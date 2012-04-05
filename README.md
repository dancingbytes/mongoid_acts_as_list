Mongoid acts as list for rails.
======


### Supported environment

Ruby:   1.9.2, 1.9.3

Rails:  3.0, 3.1, 3.2

ORM:    MondgoID (2.4)


### DSL example

    # with scope
    acts_as_list  :scope => :legal_entity

    # without scope
    acts_as_list
    

    ## Instance Methods

    move_lower
    move_higher
    increment_position
    decrement_position
    move_to_bottom
    move_to_top


### License

Authors: redfield (up.redfield@gmail.com), Tyralion (piliaiev@gmail.com)

Copyright (c) 2012 DansingBytes.ru, released under the BSD license