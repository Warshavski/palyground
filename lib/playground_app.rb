# frozen_string_literal: true

# PlaygroundApp
#
#   Used for the core app settings
#
#     - version | revision
#     - settings entry point
#
module PlaygroundApp
  class << self
    def root
      Pathname.new(File.expand_path('..', __dir__))
    end

    def config
      raise NotImplementedError
    end

    def migrations_hash
      @migrations_hash ||= Digest::MD5.hexdigest(ActiveRecord::Migrator.get_all_versions.to_s)
    end

    def revision
      path = root.join('REVISION')

      @revision ||=
        if File.exist?(path)
          begin
            File.read(path).strip.freeze
          rescue EOFError
            'Unknown'
          end
        else
          'Unknown'
        end
    end

    def version
      File.read(root.join('VERSION')).strip.freeze
    end
  end
end
