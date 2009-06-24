require 'test_helper'

ActiveRecord::Schema.define(:version => 1) do
  create_table :users, :force => true do |t|
    t.column :first_name, :string
    t.column :last_name, :string
  end
end

class User < ActiveRecord::Base
  acts_as_stripped
end

class ActsAsStrippedTest < Test::Unit::TestCase
  context 'a basic user instance' do
    setup do
      @user = User.new
    end
    should "strips all attributes of extra whitespace" do
      @user.first_name = '  ryan  '
      @user.last_name = '  sonnek  '

      @user.save!
      assert_equal 'ryan', @user.first_name
      assert_equal 'sonnek', @user.last_name
    end
  end
end
