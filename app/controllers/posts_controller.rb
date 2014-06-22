class PostsController < ApplicationController
	before_action :set_group
	before_action :login_required, :only => [:edit, :update, :new, :create, :destroy]

	def new
		@post = @group.posts.build
	end

	def create
		@post = current_user.posts.new(post_params)
		@post.author = current_user
		@post.group = @group
		#don't know why need this line to save group_id attribute
		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id])
		if @post.update(post_params)
			redirect_to group_path(@group)
		else
			render :edit
		end
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@post.destroy
		redirect_to group_path(@group)
	end

	private
	def post_params
		params.require(:post).permit(:content)
	end

	def set_group
		@group = Group.find(params[:group_id])	
	end
end
