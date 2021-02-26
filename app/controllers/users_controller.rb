class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @hashtags = Hashtag.with_questions
  end

  def new
    redirect_to root_path, alert: 'Вы уже залогинены!' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены!' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Ваш профиль удалён!'
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    begin
      @user ||= User.find params[:id]
    rescue ActiveRecord::RecordNotFound
      reject_user
    end   
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, 
                                  :name, :username, :avatar_url, :background_color)
  end
end
