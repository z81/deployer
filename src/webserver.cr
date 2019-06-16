require "http/server"
require "router"
require "./config"
require "./compose"

class WebServer
  include Router

  def draw_routes
    post "/hook/:app_name/:token" do |context, params|
      config = Config.find_and_read

      if config.is_a?(Nil)
        context.response.status_code = 400
        context.response.print "Not found config file!"
      elsif params["token"] != config.token
        context.response.status_code = 403
      else
        app_name = params["app_name"]
        app_filename = "#{app_name}.yaml"
        root_path = config.dockerCompose.rootPath
        out_path = Path.new(root_path, app_filename).to_s

        File.write(out_path, context.request.body)

        if Compose.restart(root_path, app_filename)
          context.response.print "Ok"
        else
          context.response.status_code = 502
          context.response.print "error"
        end
      end

      context
    end
  end

  def run(port)
    puts "Listening on http://0.0.0.0:#{port}"
    server = HTTP::Server.new(route_handler)
    server.bind_tcp "0.0.0.0", port
    server.listen
  end
end
