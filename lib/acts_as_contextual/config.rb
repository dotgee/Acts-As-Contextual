require 'active_support/configurable'

module ActsAsContextual
 def self.configure(&block)
    yield @config ||= ActsAsContextual::Configuration.new
  end

  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :current_context

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.current_context = nil
  end
end
