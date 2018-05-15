require 'rails'
require 'ruby2xlsx'

module Ruby2xlsx
  class Engine < ::Rails::Engine
    initializer 'ruby2xlsx.setup' do
      ::Mime::Type.register 'application/vnd.ms-excel', :xlsx

      ::ActionView::Template.register_template_handler :xrb, Ruby2xlsx::Xrb.new

      ::ActionController::Renderers.add :xlsx do |collection, options|
        doc = Ruby2xlsx::Document.new(collection, options)
        send_data(doc.render, filename: doc.filename,
                              type: 'application/vnd.ms-excel',
                              disposition: 'attachment')
      end
    end
  end
end
