require_relative '../constants'
require 'json'

class Session
  attr_reader :cookie
  
  def initialize(req)
    app_cookie = req.cookies.find { |c| c.name == APP_NAME }
    @cookie = app_cookie.nil? ? {} : JSON.parse(app_cookie.value)
  end
  
  def [](key)
    @cookie[key]
  end
  
  def []=(key, value)
    @cookie[key] = value
  end
  
  def store_session(res)
    app_cookie = WEBrick::Cookie.new(APP_NAME, @cookie.to_json)
    res.cookies << app_cookie
  end

end

