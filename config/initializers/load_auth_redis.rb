require 'redis'

AUTH_REDIS_CONFIG = YAML.load_file(File.dirname(__FILE__) + '/../../config/auth.yml')
AccessToken.establish_connection! AUTH_REDIS_CONFIG[Rails.env]
