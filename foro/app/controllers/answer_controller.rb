class AnswerController < ApplicationController
before_action :require_login, except: [:index]
before_action :set_question
  def index
    @answers = @question.answers.order('updated_at DESC')
    render json: @answers.map { |answer|
      { content: answer.content,
        updated_at: answer.updated_at,
        id: answer.id }
    }, status: 200
  end

  def create
    @answer = @question.answers.new(answer_params) if current_user.present?
    @answer.user_id = current_user.id
    if @answer.save
      render json: @answer, status: :created
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end
  private

  def user_answer
  	answer = if current_user?
  		Answer.find(params[:id])
  	else
  		current_user.answers.find(params[:id])
  	end
  	answer
  end

  def set_answer
  	@answer = @question.answers.find(params[:id])
  end

  def set_question
  	@question = Question.find params[:question_id]
  end

  def answer_params
  	params.permit(
   		:content,
   		:question_id,
   		:user_id
   		)
  end
end
