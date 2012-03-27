module Ruby2xlsx
  class Document < Base
    def render
      date_format = workbook.add_format(:num_format => 'dd.mm.yyyy')
      time_format = workbook.add_format(:num_format => 'dd.mm.yyyy HH:MM')
      
      each_with_index do |record, index|
        row = index + 1
        
        columns_names.each_with_index do |column, num|
          value = record.send(column)
          
          case value
          when Date then 
            worksheet.write_string(row, num, value.strftime("%Y-%m-%dT"), date_format)
          when DateTime, Time then 
            worksheet.write_date_time(row, num, value.strftime("%Y-%m-%dT%H:%M:%S.%L"), time_format)
          when String then
            worksheet.write_string(row, num, value)
          else
            worksheet.write(row, num, value)
          end
        end
      end
      
      bold = workbook.add_format(:bold => 1)
      worksheet.write('A1', human_columns_names, bold)
      
      super
    end
    
    def columns_names
      @columns_names ||= (@options[:columns] || @klass.column_names)
    end
    
    def human_columns_names
      @human_columns_names ||= columns_names.map { |column| @klass.human_attribute_name(column.to_s) }
    end
    
    def worksheet_name
      @worksheet_name ||= (@options[:worksheet_name] || @klass.model_name.human)
    end
    
    def filename
      @filename ||= [(@options[:filename] || @klass.model_name.plural || "document"), ".xls"].join
    end
    
    def each_with_index
      count = 0
      if @source.is_a?(::ActiveRecord::Relation)
        @klass ||= @source.klass
        
        @source.find_each do |item|
          yield item, count
          count += 1
        end
      else
        items = Array.wrap(@source)
        @klass ||= items.first.class unless items.empty?
        @klass ||= Default
        
        items.each do |item|
          yield item, count
          count += 1
        end
      end
    end
  end
end
