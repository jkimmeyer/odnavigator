module Api
  class DocumentationController < ApplicationController
    layout false
    skip_before_action :verify_authenticity_token
    
    def show
      respond_to do |format|
        format.html { render :show }
        format.js { send_file Rails.root.join('node_modules', 'redoc', 'bundles', 'redoc.standalone.js') }
        format.json { send_file Rails.root.join('doc', 'api.yml') }
      end
    end
  end
end
