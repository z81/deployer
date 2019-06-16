require "./config"
require "./webserver"

config = Config.find_and_read

if config.is_a?(Nil)
  puts "Not found config file!"
else
  server = WebServer.new
  server.draw_routes
  server.run(config.port)
end
