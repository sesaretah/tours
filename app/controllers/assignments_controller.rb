class AssignmentsController < ApplicationController
  before_action :check_user, only: [:create, :destroy]
  def create
    @assignment = Assignment.create(user_id: params[:user_id], role_id: params[:role_id])
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
  end

  def check_user
    if !grant_access("ability_to_assign_roles", current_user)
      head(403)
    end
  end
end
