module ActsAsStripped
  module ClassMethods
    def acts_as_stripped(*attrs)
      class_attribute :acts_as_stripped_attributes
      self.acts_as_stripped_attributes = attrs

      before_validation :strip_fields

      include ActsAsStripped::InstanceMethods
    end
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

ActiveRecord::Base.extend(ActsAsStripped::ClassMethods)
