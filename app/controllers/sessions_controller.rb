class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Вы успешно залогинились'
    else
      flash.now.alert = 'Неправильный email или пароль'
      render :now
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Вы успешно вышли!'
  end
end
