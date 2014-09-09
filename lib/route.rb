class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method, = pattern, http_method
    @controller_class, @action_name = controller_class, action_name
  end

  def matches?(req)
    (req.request_method.downcase.to_sym == http_method) &&
      !pattern.match(req.path).nil?
  end

  def run(req, res)
    matched = pattern.match(req.path)

    route_params = matched.names.each_with_object({}) do |name, route_params|
      route_params[name] = matched[name]
    end

    controller_class.new(req, res, route_params).invoke_action(action_name)
  end
end