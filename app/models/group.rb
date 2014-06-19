class Group < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	belongs_to :owner, :class_name => "User", :foreign_key => :user_id
	validates :title, :presence => true

	def editable_by?(user)
		user && user == owner
	end
end
