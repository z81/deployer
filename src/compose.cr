class Compose
  def self.restart(path : String, filename : String)
    down_and_cd = "cd #{path} && docker-compose -f #{filename} down"
    pull_and_up = "docker-compose -f #{filename} pull && docker-compose -f #{filename} up -d"
    system "#{down_and_cd} && #{pull_and_up}"
  end
end
