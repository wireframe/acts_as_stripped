require 'test_helper'

ActiveRecord::Schema.define(:version => 1) do
  create_table :posts, :force => true do |t|
    t.column :title, :string
    t.column :body, :string
  end
end

class Post < ActiveRecord::Base
  acts_as_stripped :title
end

class ActsAsStrippedTest < Test::Unit::TestCase
  context 'a basic post instance' do
    setup do
      @post = Post.new
    end
    should 'strip whitespace from title' do
      @post.title = '  hello world  '
      @post.save!
      
      assert_equal 'hello world', @post.title
    end
    should 'not strip whitespace from body' do
      @post.body = '  awesome  '
      @post.save!
      
      assert_equal '  awesome  ', @post.body
    end
    should 'not fail if title is nil' do
      @post.title = nil
      assert_nothing_raised do
        @post.save!
      end
      assert_nil @post.title
    end
  end
end
