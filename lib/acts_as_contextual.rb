require "acts_as_contextual/version"
require 'active_record'

require "acts_as_contextual/config"
require "acts_as_contextual/contextualizable"
require "acts_as_contextual/acts_as_contextual"
require "acts_as_contextual/acts_as_contextualizer"
require "acts_as_contextual/context_helper"
module ActsAsContextual
end

if defined?(ActionView::Base)
  ActionView::Base.send :include, ActsAsContextual::ContextHelper
end
