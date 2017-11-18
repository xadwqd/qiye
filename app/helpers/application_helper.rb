module ApplicationHelper
  def is_active?(expected_value, actual_value)
    expected_value == actual_value ? 'active' : ''
  end

  def qiniu_url(url)
    "http://olavg5ba4.bkt.clouddn.com/#{url}"
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
