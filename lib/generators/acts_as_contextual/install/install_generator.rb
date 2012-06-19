module ActsAsContextual
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "install necessaries for contextual"
      source_root File.expand_path("../templates", __FILE__)

      include Rails::Generators::Migration
      def self.next_migration_number(dirname)
          Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_migrations
        Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          migration_template "migrations/#{name}", "db/migrate/#{name.gsub(/^\d+_/,'')}"
          sleep 1
        end
      end 
      def copy_config_file
        template 'initializers/acts_as_contextual_config.rb', 'config/initializers/acts_as_contextual_config.rb'
      end
    end
  end
end
