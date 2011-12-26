# encoding: utf-8
module ActsAsList

  module Order

    module ClassMethods
    end # ClassMethods

    module InstanceMethods
      
      def increment_position

        return unless in_list?
        self.inc(:position, 1)

      end # increment_position
      
      def decrement_position

        return unless in_list?
        
        self.inc(:position, -1)

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
        self.position = nil
        self_class.update_all(:position => self.position)

      end # remove_from_list
      
      def in_list?
        !self.position.nil?
      end # in_list?

      private
      
      def self_class
        @self_class ||= self.embedded? ? self._parent.try(self.collection_name) : self.class
      end # self_class
      
      def add_to_list_bottom
        self.position = (bottom_item.try(:position) || 0).to_i + 1
      end # add_to_list_bottom
      
      def bottom_item
        
        self_class.desc(:position).first

      end # bottom_item
      
      def decrement_positions_on_lower_items

        return unless in_list?
        self_class.where(
          :position.gt => self.position.to_i
          ).each do |m|
            m.inc(:position, -1)
          end # each

      end # decrement_positions_on_lower_items
      
      def increment_positions_on_higher_items

        return unless in_list?
        self_class.where(
          :position.lt => self.position.to_i
          ).each do |m|
            m.inc(:position, 1)
          end # each

      end # increment_positions_on_higher_items
      
      def assume_bottom_position

        self.position = (bottom_item(self).try(:position) || 0).to_i + 1
        self_class.update_all(:position => self.position)

      end # assume_bottom_position
      
      def assume_top_position

        self.position = 1
        self_class.update_all(:position => self.position)

      end # assume_top_position
      
      def eliminate_current_position
        decrement_positions_on_lower_items if in_list?
      end # eliminate_current_position

    end # InstanceMethods

  end # Order

end # ActsAsFiles