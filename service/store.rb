# frozen_string_literal: true

require 'file_db/db'

class Store
  attr_reader :name, :db

  def initialize(name)
    @db = FileDatabase.new(name)
    @name = name
  end

  def save(data)
    db.save(data)
    db.save_metadata
  rescue StandardError => e
    print "Error: Could not save in the store. \n #{e}"
  end

  def select_metadata
    db.select_metadata
  rescue StandardError => e
    print "Error: Could not select metadata. \n #{e}"
    {}
  end
end
