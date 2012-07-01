# encoding: utf-8
require 'mongoid_acts_as_list/list'

module MongoidActsAsList
  
  module Base

    def acts_as_list(options = {})

      include ::MongoidActsAsList::List::InstanceMethods
      
      position_field  = options.fetch(:field, :position).try(:to_sym)
      scope_field     = options.fetch(:scope, nil).try(:to_sym)

      field position_field,   type: Integer
      
      # For mongoid 2.4
      unless (::Mongoid::VERSION =~ /\A2.4/).nil?

        if scope_field.nil?
          
          default_scope order_by([position_field, :asc])
          index position_field

        else
          
          default_scope order_by([position_field, :asc], [scope_field, :asc])

          index(

            [
              [ position_field, Mongo::ASCENDING ],
              [ scope_field,    Mongo::ASCENDING ]
            ],
            name: "acts_as_list_indx"
            
          )

        end # if

      else
      
        # For mongoid 3

        if scope_field.nil?
          
          default_scope order_by([position_field, :asc])
          index({ "#{position_field}".to_sym => 1 })

        else
          
          default_scope order_by([position_field, :asc], [scope_field, :asc])

          index({

            "#{position_field}".to_sym  => 1,
            "#{scope_field}".to_sym     => 1

          }, {  
            name: "acts_as_list_indx"            
          })

        end # if

      end  

      define_method(:acts_as_list_position_field) { position_field }

      define_method(:acts_as_list_scope_fields) { 
        scope_field.nil? ? nil : { scope_field => self[scope_field] }
      }

      set_callback :create,  :before,  :add_to_list_bottom
      set_callback :destroy, :before,  :remove_from_list

    end # act_as_files

  end # Base

end # MongoidActsAsList

Mongoid::Document::ClassMethods.send(:include, MongoidActsAsList::Base)