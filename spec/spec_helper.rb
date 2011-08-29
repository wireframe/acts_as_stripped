require 'rubygems'
require 'bundler/setup'

require 'acts_as_stripped'
require 'logger'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
# Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# include Devise::TestHelpers

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  config.before(:suite) do
    puts 'setting up database'
    config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
    ActiveRecord::Base.logger = Logger.new STDOUT
    ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite'])

    ActiveRecord::Schema.define(:version => 1) do
      create_table :posts, :force => true do |t|
        t.column :title, :string
        t.column :body, :string
      end
    end
  end
end
