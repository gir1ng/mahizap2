class SecretsController < ApplicationController
  def index
    if session[:secret_password].nil?
      flash[:danger] = "パスワードを入力してください"
      redirect_to secret_login_url
    else
      get_chart_data
    end
  end

  def new
    @secret = Secret.new
  end

  def create
    logger.debug("ぱらむ------")
    logger.debug(params[:secret][:weight])
    encrypted = get_crypt.encrypt_and_sign(secret_params[:weight])
    logger.debug("えんくり------")
    logger.debug(encrypted)
    @secret = current_user.secrets.build(weight: encrypted)
    if @secret.save
      flash[:success] = "体重の登録が完了しました"
      redirect_to secrets_url
    else
      render "new"
    end
  end

  private

  def secret_params
    params.require(:secret).permit(:weight)
  end

  def get_crypt
    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = Rails.application.key_generator.generate_key("salt", key_len)
    ActiveSupport::MessageEncryptor.new(secret)
  end

  def get_chart_data
    secrets = current_user.secrets
    if @chart_data.nil?
      @chart_data = {}
      secrets.each do |secret|
        @chart_data[secret.created_at.strftime("%Y/%m/%d")] = get_crypt.decrypt_and_verify(secret.weight)
      end
    end
  end
end
