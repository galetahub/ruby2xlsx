require 'writeexcel'
require 'stringio'

module Ruby2xlsx
  class Base
    # Constructs a new ejs engine based on given xlsx", :root => true, :view_path => "/path/to/views" })
    #
    def initialize(source, options = {})
      @source = source
      @options = options
      @compiled = false
      @io = ::StringIO.new
    end
    
    def workbook
      @workbook ||= ::WriteExcel.new(@io)
    end
    
    def worksheet
      @worksheet ||= add_worksheet(worksheet_name)
    end
    
    def add_worksheet(*args)
      @worksheet = workbook.add_worksheet(*args)
    end
    
    def render(*args)
      workbook.close
      @io.string
    end
    
    def worksheet_name
      "somename"
    end
    
    def method_missing(m, *args, &block)
      if worksheet.respond_to?(m)
        worksheet.send(m, *args, &block)
      elsif workbook.respond_to?(m)
        workbook.send(m, *args, &block)
      else
        super
      end
    end
  end
end
