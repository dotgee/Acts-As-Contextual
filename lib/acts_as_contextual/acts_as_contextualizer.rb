module ActsAsContextual
  module ActsAsContextualizer
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_contextualizer
       
      end
    end

    module InstanceMethods

    end
  end
end

ActiveRecord::Base.send :include, ActsAsContextual::ActsAsContextualizer
