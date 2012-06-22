Mongoid acts as list for rails.
======


### Supported environment

Ruby:   1.9.2, 1.9.3

Rails:  3.0, 3.1, 3.2

ORM:    MondgoID (2.4)


### DSL example


    ## Without scope
    class Item

      include Mongoid::Document
      acts_as_list

    end

    ## With scope
    class Item

      include Mongoid::Document
      acts_as_list  scope: catalog_id

    end


    ## With embeded codument (with scope or not)
    class Comment

      include Mongoid::Document
      embedded_in :post

      acts_as_list

    end

    class Post

      include Mongoid::Document
      embeds_many :comments

    end


    ## Instance Methods
    move_lower ( alias: down )
    move_higher ( alias: up )
    increment_position
    decrement_position
    move_to_bottom ( alias: to_down )
    move_to_top ( alias: to_up )


### License

Authors: redfield (up.redfield@gmail.com), Tyralion (piliaiev@gmail.com)

Copyright (c) 2012 DansingBytes.ru, released under the BSD license