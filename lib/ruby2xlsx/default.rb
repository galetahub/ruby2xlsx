require 'active_model/naming'
require 'active_model/translation'

module Ruby2xlsx
  class Default
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    
    def self.column_names
      [:id]
    end
  end
end
