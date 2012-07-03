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
            contextualized
          end 
        end if opts[:default_scoped]

        scope :contextualized, lambda { |ctx = ActsAsContextual.config.current_context |
            where(["#{Contextualizable.table_name}.contextualizer_id = ? and #{Contextualizable.table_name}.contextualizer_type = ?", ctx.id, ctx.class.name]).includes(:contextualizable)
        }
      
        def each_with_context(opts = {})
          order_by = opts[:order_by] || :id
          unscoped.includes({:contextualizable => :contextualizer}).order(order_by).all.group_by(&:contextualizer)
        end
      end
    end

    module InstanceMethodsOnlyActsAsContext
      
      def contextualizer
        return contextualizable.contextualizer if contextualizable
        nil
      end

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
