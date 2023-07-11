class User < ActiveRecord::Base # rubocop:disable Rails/ApplicationRecord
  has_many :accounts
end
