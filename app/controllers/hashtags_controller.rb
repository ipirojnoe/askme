class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by(text: params[:text])

    if @hashtag.nil?
      redirect_to root_path, notice: 'Такого хэштэга нет'
    else
      @questions = @hashtag.questions
    end
  end
end
