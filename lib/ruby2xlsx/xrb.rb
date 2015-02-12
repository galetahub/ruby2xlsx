module Ruby2xlsx
  class Xrb
    # Default format used by Excel builder.
    class_attribute :default_format
    self.default_format = ::Mime::XLSX

    def call(template)
      %{ controller.send_data ::Ruby2xlsx::Template.new(#{template.source.inspect}).render(self, assigns.merge(local_assigns)),
          :filename => [controller.instance_variable_get(:@xlsx_filename) || controller.action_name, ".xls"].join, 
          :type => "application/vnd.ms-excel", 
          :disposition => "attachment" }
    end
  end
end
