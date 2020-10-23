module IdsAvm
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../../templates", __FILE__)
      desc "Sets up the IDS Avm configuration"

      def copy_config
        template "ids_avm.rb", "config/initializers/ids_avm.rb"
      end
    end
  end
end
