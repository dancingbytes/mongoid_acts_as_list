# encoding: utf-8
module MongoidActsAsList

  module List

    module InstanceMethods
      
      def move_lower
        
        lower = lower_item
        return unless lower
        
        lower.decrement_position
        self.increment_position
        
      end # move_lower
      
      def move_higher
        
        higher = higher_item
        return unless higher
        
        higher.increment_position
        self.decrement_position
        
      end # move_higher

      def increment_position

        return unless in_list?
        self.inc(acts_as_list_position_field, 1)

      end # increment_position
      
      def decrement_position

        return unless in_list?
        self.inc(acts_as_list_position_field, -1)

      end # decrement_position
      
      def move_to_bottom

        return unless in_list?
        
        decrement_positions_on_lower_items
        assume_bottom_position

      end # move_to_bottom
      
      def move_to_top

        return unless in_list?

        increment_positions_on_higher_items
        assume_top_position

      end # move_to_top
      
      def remove_from_list

        return unless in_list?

        decrement_positions_on_lower_items
        self[acts_as_list_position_field] = nil
        self_class.update_all(acts_as_list_position_field => self[acts_as_list_position_field])

      end # remove_from_list
      
      def in_list?
        !self.position.nil?
      end # in_list?

      private
      
      def self_class
        
        @self_class ||= if self.embedded?
          self._parent.try(self.collection_name).where(acts_as_list_position_field.ne => nil) 
        else 
          self
        end

        @self_class.acts_as_list_scope_fields

      end # self_class
      
      def add_to_list_bottom
        self.position = (bottom_item.try(acts_as_list_position_field) || 0).to_i + 1
      end # add_to_list_bottom
      
      def bottom_item        
        self_class.desc(acts_as_list_position_field).first
      end # bottom_item
      
      def lower_item
        self_class.where(acts_as_list_position_field => self[acts_as_list_position_field] + 1).first
      end # lower_item
      
      def higher_item
        self_class.where(acts_as_list_position_field => self[acts_as_list_position_field] - 1).first
      end # higher_item
      
      def decrement_positions_on_lower_items

        return unless in_list?
        self_class.where(
          acts_as_list_position_field.gt => self[acts_as_list_position_field]
        ).each do |m|
          m.inc(acts_as_list_position_field, -1)
        end # each

      end # decrement_positions_on_lower_items
      
      def increment_positions_on_higher_items

        return unless in_list?
        self_class.where(
          acts_as_list_position_field.lt => self[acts_as_list_position_field]
        ).each do |m|
          m.inc(acts_as_list_position_field, 1)
        end # each

      end # increment_positions_on_higher_items
      
      def assume_bottom_position

        self[acts_as_list_position_field] = (bottom_item(self).try(acts_as_list_position_field) || 0).to_i + 1
        self_class.update_all(acts_as_list_position_field => self[acts_as_list_position_field])

      end # assume_bottom_position
      
      def assume_top_position

        self[acts_as_list_position_field] = 1
        self_class.update_all(acts_as_list_position_field => self[acts_as_list_position_field])

      end # assume_top_position
      
    end # InstanceMethods

  end # List

end # MongoidActsAsList