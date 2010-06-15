module ActsAsStripped
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_stripped(*attrs)
      class_inheritable_accessor :acts_as_stripped_attributes
      self.acts_as_stripped_attributes = attrs if attrs.any?

      before_validation :strip_fields

      include ActsAsStripped::InstanceMethods
      extend ActsAsStripped::SingletonMethods          
    end
  end

  module SingletonMethods
  end
  
  module InstanceMethods
    private
    def strip_fields
      self.acts_as_stripped_attributes.each do |attr|
        self[attr.to_s].strip! unless self[attr.to_s].nil?
      end
    end
  end
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, ActsAsStripped)
end
