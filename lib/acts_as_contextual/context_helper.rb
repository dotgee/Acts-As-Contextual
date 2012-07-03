module ActsAsContextual 
  module ContextHelper
    def each_in_context(contextualized_klass, opts = {}, &block)
      order_by = opts.delete(:order_by) || :id
      eachs = contextualized_klass.each_with_context(opts).sort(order_by)
      eachs = eachs.to_a.select{|c,itms| !c.nil? }
      sort = opts.delete(:context_sort) || :id
      sort_order = opts.delete(:reverse) || false
      eachs.sort!{|a,b| a.first.send(sort) <=> b.first.send(sort) }
      eachs.reverse! if sort_order
      cpt = 0
      eachs.each do |context, items|
        yield context, items, cpt
        cpt += 1
      end
    end
  end
end
