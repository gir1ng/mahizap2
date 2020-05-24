class SecretsController < ApplicationController
  def index
    if session[:password].nil?
      render "index" and return if params[:password].nil?
      session[:password] = params[:password]
      redirect_to secrets_url and return
    end
    password = session[:password]
    session.delete(:password)

    if BCrypt::Password.new(current_user.secret_password).is_password?(password)
      secrets = current_user.secrets
      if @chart_data.nil?
        @chart_data = {}
        secrets.each do |secret|
          @chart_data[secret.created_at] = get_crypt.decrypt_and_verify(secret.weight)
        end
      end
      render "index"
    else
      flash[:success] = "パスワードが違います"
      redirect_to graph_url
    end
  end

  def new
    @secret = Secret.new
  end

  def create
    # key_len = ActiveSupport::MessageEncryptor.key_len
    # secret = Rails.application.key_generator.generate_key("salt", key_len)
    # crypt = ActiveSupport::MessageEncryptor.new(secret)
    encrypted = get_crypt.encrypt_and_sign(secret_params[:weight])
    @secret = current_user.secrets.build(weight: encrypted)
    # 複合化
    # @a = crypt.decrypt_and_verify(encrypted)
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
end
