require "yaml"

class DockerCompose
  YAML.mapping(
    rootPath: String,
  )
end

class Config
  YAML.mapping(
    port: Int32,
    token: String,
    dockerCompose: DockerCompose,
  )

  def self.from_file(filename : String)
    Config.from_yaml(File.read(filename))
  end

  def self.find_and_read
    config_filename = ".deployer-config.yaml"
    root_config_path = Path.new(ENV["HOME"], config_filename).to_s
    local_config_path = Path.new(Dir.current, config_filename).to_s
    config_path = ""

    if File.exists?(root_config_path)
      config_path = root_config_path
    elsif File.exists?(local_config_path)
      config_path = local_config_path
    end

    if config_path != ""
      self.from_file(config_path)
    else
      nil
    end
  end
end
