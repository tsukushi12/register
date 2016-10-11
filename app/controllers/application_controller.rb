class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Jpmobile::ViewSelector
  rescue_from Exception, with: :rescue500



  rescue_from ActionController::RoutingError, with: :rescue404
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    def rescue500(e)
#      logger.error [e, *ebacktrace].join("\n")
      redirect_to root_path, alert: "ごめんね。サーバに問題が発生したよ"
    end

    def rescue404(*e)
      redirect_to root_path, alert: "ごめんね。URLが見つからないよ"
    end
end
