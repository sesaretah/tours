class RolesController < ApplicationController
  before_action :check_user, only: [:create, :destroy, :access]

  def change_current_role
    @role = Role.find(params[:role_id])
    @assignment = Assignment.where(role_id: @role.id, user_id: current_user.id)
    if !@assignment.blank?
      current_user.current_role_id = params[:role_id]
      current_user.save
    end
  end

  def access
    @role = Role.find(params[:id])
    if !@role.access_control.blank?
      @access_control = AccessControl.where(role_id: @role.id).first
    else
      @access_control = AccessControl.new
    end
  end

  def create
    @role = Role.create(title: params[:title])
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
  end

  def check_user
    if !grant_access("ability_to_change_roles", current_user)
      head(403)
    end
  end

end
