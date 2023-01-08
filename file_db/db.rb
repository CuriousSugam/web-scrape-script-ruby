# frozen_string_literal: true

require 'json'

class FileDatabase
  attr_reader :name

  DB_PATH = 'db.json'

  def initialize(name)
    @name = name
  end

  def save(data)
    File.open("#{name}.html", 'w+') { |file| file.write(data) }
  end

  def save_metadata
    map = {}
    if File.exist?(DB_PATH)
      file = File.read(DB_PATH)
      map = JSON.parse(file) unless file.size.zero?
    end

    _data = map[name]
    _data = {} if _data.nil?
    _data['last_fetch'] = Time.now.utc.strftime('%a %b %d %Y%k:%M UTC')

    map[name] = _data

    File.open(DB_PATH, 'w+') { |file| file.write(map.to_json) }
  end

  def select_metadata
    file = File.read(DB_PATH)
    return {} if file.size.zero?

    map = JSON.parse(file)
    map[name] || {}
  end
end
