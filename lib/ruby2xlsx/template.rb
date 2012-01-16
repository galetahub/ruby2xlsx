module Ruby2xlsx
  class Template < Base
    
    # Renders the representation based on source, object, scope and locals
    # Template.new("...source...", { :format => "xlsx" }).render(scope, { :foo => "bar", :object => @user })
    #
    def render(scope, locals, &block)
      @locals, @scope = locals, scope
      set_locals_variables
      
      instance_eval(@source) if @source.present?
      instance_eval(&block) if block_given?
      
      super
    end
    
    protected
    
      def set_locals_variables
        @locals.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end
  end
end
