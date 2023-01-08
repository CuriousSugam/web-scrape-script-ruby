require 'json'

class LogService

  def self.log(data)
    print data
  end

  def self.debug(data)
    print data if log_level == 'debug'
  end

  def self.log_level
    file = File.read('config.rb')
    configs = JSON.parse(file)

    configs['log_level']
  end
end