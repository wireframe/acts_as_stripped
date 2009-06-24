module ActsAsStripped
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_stripped
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
      self.attributes.each_key {|a| self[a].strip! if self[a].respond_to? :strip! }
    end
  end
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, ActsAsStripped)
end
