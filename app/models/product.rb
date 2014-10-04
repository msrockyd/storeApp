class Product < ActiveRecord::Base
	has_attached_file :image, :styles => {:thumb => "440x270"}
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	has_many :base_carts
end
