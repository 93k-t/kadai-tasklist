class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  
  private
  # ログイン要求処理
  def require_user_logged_in
  # true current_userにログインユーザの情報が入り処理は実行されない,false unlessメソッドが実行され強制的にログイン画面に飛ばされる
    unless logged_in?
      redirect_to login_url
    end
  end
end
