class Route
  attr_reader :pattern, :method, :controller, :action
  
  def initialize(pattern, method, controller, action)
    @pattern, @method = pattern, method
    @controller, @action = controller, action
  end
  
  def matches?(req)
    req.request_method.downcase.to_sym == @method && pattern.match(req.path)
  end
  
end