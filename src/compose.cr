class Compose
  def self.restart(path : String, filename : String)
    down_and_cd = "cd #{path} &&  && docker-compose -f #{filename} pull"
    pull_and_up = "docker-compose -f #{filename} restart"
    system "#{down_and_cd} && #{pull_and_up}"
  end
end
