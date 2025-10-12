# config/initializers/force_psych_time_patch.rb
require 'yaml'

module YAML
  class << self
    alias_method :_original_safe_load, :safe_load

    def safe_load(content, *args, **kwargs)
      permitted = kwargs[:permitted_classes] || []
      permitted << Time unless permitted.include?(Time)
      kwargs[:permitted_classes] = permitted
      _original_safe_load(content, *args, **kwargs)
    end
  end
end

Rails.logger.info "[GLOBAL PATCH] YAML.safe_load now permits Time"
