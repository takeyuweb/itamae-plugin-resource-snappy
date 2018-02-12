require 'itamae'

module Itamae
  module Plugin
    module Resource
      class Snappy < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :package_name, type: String, default_name: true
        define_attribute :options, type: [String, Array], default: []
        define_attribute :classic, type: [TrueClass, FalseClass], default: false

        def pre_action
          case @current_action
            when :install
              attributes.installed = true
            when :remove
              attributes.installed = false
          end
        end

        def set_current_attributes
          current.installed = installed_snaps.include?(attributes.package_name)
        end

        def action_install(_action_options)
          return if current.installed
          install!
          updated!
        end

        def action_remove(_action_options)
          remove! if current.installed
        end

        def installed_snaps
          snaps = []
          run_command(['snap', 'list']).stdout.each_line do |line|
            if /\A(\S+)\s+(\S+)/ =~ line.strip
              name, _version, _rev, _developer, _notes = $1
              snaps << name if name != 'Name'
            end
          end
          snaps
        rescue Backend::CommandExecutionError
          []
        end

        def install!
          cmd = ['snap', 'install', *Array(attributes.options)]
          cmd << '--classic' if attributes.classic
          cmd << attributes.package_name

          run_command(cmd)
        end

        def remove!
          cmd = ['snap', 'remove']
          cmd << attributes.package_name

          run_command(cmd)
        end
      end

    end
  end
end
