class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [:city_id]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    if current_worker.has_role?(:admin)
      workers_path
    elsif current_worker.has_role?(:yunying)
      categories_path
    elsif current_worker.has_role?(:fenchengshi)
        stations_path
    end
  end

  def after_sign_out_path_for(resource)
    new_worker_session_path
  end


  def current_ability
    @current_ability ||= ::Ability.new(current_worker)
  end

  def current_city
    unless session[:current_city_id]
      session[:current_city_id] = current_worker.cities.first.id if current_worker.cities.first
    end
    if session[:current_city_id]
      @current_city ||= City.find(session[:current_city_id])
    else
      @current_city = nil
    end
  end
end
