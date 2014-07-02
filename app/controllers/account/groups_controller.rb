class Account::GroupsController < ApplicationController
before_action :login_required

def index
	@group = current_user.participated_groups.order("posts_count ASC")
	@post = current_user.posts.order("updated_at DESC")
end

end
