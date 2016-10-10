class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Jpmobile::ViewSelector
#  rescue_from Exception, with: :rescue500

  rescue_from ActionController::RoutingError, with: :rescue404
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404

    def rescue500
      redirect_to root_path, "ごめんね。"
    end

    def rescue404(e)
      redirect_to root_path, "ごめんね。URLが見つからないよ"
    end
end
