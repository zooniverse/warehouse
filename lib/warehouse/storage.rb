require 'sequel'
Sequel.extension :migration
Sequel.extension :pg_json
Sequel.extension :pg_json_ops

module Warehouse
  class Storage
    attr_reader :db

    def self.migrate(db)
      Sequel::Migrator.run(db, File.expand_path("../../../db/migrations", __FILE__))
    end

    def initialize(db)
      @db = db
      self.class.migrate(db)
    end

    def transaction
      db.transaction do
        yield
      end
    end

    def delete_classification(id)
      db[:classifications].where("id = ?", id).delete
    end

    def insert_classification(hash)
      db[:classifications].insert(hash)
    end

    def insert_annotation(hash)
      db[:annotations].insert(hash)
    end
  end
end
