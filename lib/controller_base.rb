require_relative '../extensions/string_conversions'
require_relative 'session'
require 'erb'

class ControllerBase
  attr_reader :req, :res
  
  def initialize(req, res)
    @req, @res = req, res
    @already_built_response = false
  end
  
  def session
    @session ||= Session.new(@req)
  end
  
  def render(template_name)
    content = File.read(
    # String#uncontrollerize defined in extensions/string_conversions
      "views/#{self.class.to_s.uncontrollerize}/#{template_name}.html.erb"
    )
    
    render_content("text/html", ERB.new(content).result(binding))
  end
  
  def render_content(content_type, body)
    raise "cannot render twice" if already_built_response?
    @res.content_type = content_type
    @res.body = body
    @already_built_response = true
    session.store_session(@res)
  end
  
  def redirect_to(url)
    raise "cannot render twice" if already_built_response?
    @res.status = 302
    @res["Location"] = url
    @already_built_response = true
    session.store_session(@res)
  end
  
  def already_built_response?
    @already_built_response
  end
  
end