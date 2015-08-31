require 'active_record'

module ActsAsStripped
  module ClassMethods
    def acts_as_stripped(*attrs)
      attrs.each do |attribute|
        before_validation do |record|
          value = record[attribute]
          record[attribute] = value.strip if value
        end
      end
    end
  end
end

ActiveRecord::Base.extend(ActsAsStripped::ClassMethods)
