class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller? 
  before_action :set_business
  before_action :set_host

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  private  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:username])
    end
  protected
    def set_business
      @base_url = root_url(only_path: false)
      @now_url = request.url
      @site_name = SquareRails::Application.config.site_name
      @overview = 'Hesper.siteは小説などの投稿サイトです。気軽に登録して利用してください。'
    end
end
