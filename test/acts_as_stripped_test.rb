require 'test_helper'

ActiveRecord::Schema.define(:version => 1) do
  create_table :users, :force => true do |t|
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :logged_in_at, :datetime
  end
  create_table :posts, :force => true do |t|
    t.column :title, :string
    t.column :body, :string
  end
end

class User < ActiveRecord::Base
  acts_as_stripped
end

class Post < ActiveRecord::Base
  acts_as_stripped :title
end

class ActsAsStrippedTest < Test::Unit::TestCase
  context 'a basic user instance' do
    setup do
      @user = User.new
    end
    should "strips all string attributes of extra whitespace" do
      @user.first_name = '  ryan  '
      @user.last_name = '  sonnek  '
      @user.logged_in_at = Time.now

      @user.save!
      assert_equal 'ryan', @user.first_name
      assert_equal 'sonnek', @user.last_name
    end
    
    should "not fail if any attributes are nil" do
      @user.first_name = '  shaq  '
      @user.last_name = nil
      @user.logged_in_at = Time.now
      
      assert_nothing_raised do
        @user.save!
      end
      
      assert_equal 'shaq', @user.first_name
      assert_nil @user.last_name
    end
  end

  context 'a basic post instance' do
    setup do
      @post = Post.new
    end
    should 'not fail if title is nil' do
      @post.title = nil
      assert_nothing_raised do
        @post.save!
      end
      assert_nil @post.title
    end

    should 'strip whitespace only from title' do
      @post.title = '  hello world  '
      @post.body = '  awesome  '
      @post.save!
      
      assert_equal 'hello world', @post.title
      assert_equal '  awesome  ', @post.body
    end
  end
end
