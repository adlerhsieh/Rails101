class GroupsController < ApplicationController
	before_action :login_required, :only => [:edit, :update, :new, :create, :destroy]

	def index
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
		@post = @group.posts.all
	end

	def edit
		@group = current_user.groups.find(params[:id])
	end

	def new
		@group = Group.new
	end

	def create
		@group = current_user.groups.build(group_params)
		if @group.save
			redirect_to groups_path
			flash[:notice] = "Group successfully created"
		else
			render :new
		end
	end

	def update
		@group = current_user.groups.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path
		else
			render :edit
		end
	end

	def destroy
		@group = current_user.groups.find(params[:id])
		@group.destroy
		redirect_to groups_path
	end

	def join
		@group = Group.find(params[:id])
		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
		else
			flash[:notice] = "You are already a member."
		end	
		redirect_to group_path(@group)
	end

	def quit
		@group = Group.find(params[:id])
		if !cuttent_user.is_member_of(@group)
			current_user.quit!(@group)
		else
			flash[:notice] = "You are not a member"
		end
		edirect_to group_path(@group)
	end


	private
		def group_params
			params.require(:group).permit(:title, :description)
	end
end
