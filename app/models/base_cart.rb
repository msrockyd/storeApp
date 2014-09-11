class BaseCart < ActiveRecord::Base
	belongs_to :product
	has_one :order, foreign_key: :cart_id
end
