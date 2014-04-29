require 'rack/request'
require 'rack/response'

module Rails
  class Application
    def call(env)
      req = Rack::Request.new(env)
      res = Rack::Response.new

      # Call rails dispatch with request and get the html

      # Status
      res.status = 200 # We should set the status according to the response

      # Headers
      res['Content-Type'] = 'text/html'

      # Content
      res.write '' # We should set the content according to the response

      res.finish
    end
  end
end

# Need to move this to server.rb
require 'rack'

Rack::Server.start(app: Rails::Application.new, Port: 9292)
