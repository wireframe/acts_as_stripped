require 'spec_helper'

class Post < ActiveRecord::Base
  acts_as_stripped :title
end

describe ActsAsStripped do
  context 'a basic post instance' do
    before do
      @post = Post.new
    end
    it 'strips whitespace from title' do
      @post.title = '  hello world  '
      @post.save!

      @post.title.should == 'hello world'
    end
    it 'strips newlines from title' do
      @post.title = "hello world\n\n"
      @post.save!

      @post.title.should == 'hello world'
    end
    it 'does not strip whitespace from body' do
      @post.body = '  awesome  '
      @post.save!

      @post.body.should == '  awesome  '
    end
    it 'does not fail if title is nil' do
      @post.title = nil
      lambda do
        @post.save!
      end.should_not raise_error
      @post.title.should be_nil
    end
  end
end
