require_relative '../lib/controller_base'
require 'webrick'

class PuppiesController < ControllerBase
  def test
    puts params
    # render :show
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc("/") do |req, res|
  PuppiesController.new(req, res).test
end

trap("INT") { server.shutdown }
server.start