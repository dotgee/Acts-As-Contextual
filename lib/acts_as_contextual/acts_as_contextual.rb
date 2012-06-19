module ActsAsContextual
  module ActsAsContext
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_contextual(*options) 
        opts = options.extract_options!
        include ActsAsContext::InstanceMethodsOnlyActsAsContext
        if opts[:allow_contextualisation]
          attr_writer :context_id
          belongs_to :context, :class_name => ActsAsContextual.config.current_context.class.name
        end

        after_save :ensure_is_contextualized    

        has_one :contextualizable, :as => :contextualized
        
        default_scope do 
          unless ActsAsContextual.config.current_context.nil?
            where(["#{Contextualizable.table_name}.contextualizer_id = ? and #{Contextualizable.table_name}.contextualizer_type = ?", ActsAsContextual.config.current_context.id, ActsAsContextual.config.current_context.class.name]).includes(:contextualizable)
          end
        end

      end

    end

    module InstanceMethodsOnlyActsAsContext
      
      def context_id
        return @context_id if @context_id
        @context_id = contextualizable.contextualizer_id if contextualizable
        @context_id
      end

      def contextualize(context)
        return true unless context
        unless contextualizable
          build_contextualizable
        end
        contextualizable.contextualizer = context
        contextualizable.save
      end

      private 
        def ensure_is_contextualized
          #gere les cas de forcer ou non par défaut un context
          ctx = ActsAsContextual.config.current_context.class.find(context_id) unless context_id.blank?
          ctx ||= ActsAsContextual.config.current_context
          contextualize(ctx)
        end
    end
  end
end

ActiveRecord::Base.send :include, ActsAsContextual::ActsAsContext
