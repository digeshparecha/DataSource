# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = if params[:name]
               User.where("name ->> 'first' ILIKE :name OR name ->> 'last' ILIKE :name OR name ->> 'title' ILIKE :name",
                          name: "%#{params[:name]}%")
             else
               User.all
             end
    source = Rails.root.join('app/views/users/users_list.liquid').read
    @template = Liquid::Template.parse(source, error_mode: :strict)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to root_path
  end
end
