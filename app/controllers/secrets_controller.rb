class SecretsController < ApplicationController
  def index
    if session[:secret_password].nil?
      if params[:password].nil?
        get_chart_data
        render "index" and return
      end
      session[:secret_password] = params[:password]
      redirect_to secrets_url and return
    end
    password = session[:secret_password]
    session.delete(:secret_password)

    if BCrypt::Password.new(current_user.secret_password).is_password?(password)
      # secrets = current_user.secrets
      # if @chart_data.nil?
      #   @chart_data = {}
      #   secrets.each do |secret|
      #     @chart_data[secret.created_at] = get_crypt.decrypt_and_verify(secret.weight)
      #   end
      # end
      get_chart_data
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
    encrypted = get_crypt.encrypt_and_sign(secret_params[:weight])
    @secret = current_user.secrets.build(weight: encrypted)
    if @secret.save
      flash[:success] = "体重の登録が完了しました"
      get_chart_data
      render "index"
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
