# encoding: utf-8
module ActsAsList

  class Railtie < ::Rails::Railtie #:nodoc:
    
    initializer 'acts_as_list' do |app|
    
      Mongoid::Document::ClassMethods.send(:include, ActsAsList::Order)

    end

  end

end
