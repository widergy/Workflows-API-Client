class Account < ActiveRecord::Base # rubocop:disable Rails/ApplicationRecord
  belongs_to :user
end
