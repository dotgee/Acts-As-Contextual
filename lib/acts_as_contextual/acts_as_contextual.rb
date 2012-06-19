module ActsAsContextual
  module ActsAsContext
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_contextual 
        after_save :ensure_is_contextualized    
      end
    end

    module InstanceMethods
      private 
        def ensure_is_contextualized
          puts "ok"
        end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContextual::ActsAsContext
