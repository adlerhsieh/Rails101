class Group < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	validates :title, :presence => true
end
