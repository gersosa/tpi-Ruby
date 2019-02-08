class QuestionController < ApplicationController
	before_action :require_login, except: [:index]


	def index
		if params[:sort]=='pending_first'
			@questions = Question.where('answer_id== ?',nil ).order('created_at DESC').first(50)
		else
			@questions = Question.order('created_at DESC').first(50)
		end
		render json: @questions.map { |question| question.attributes.merge( {author: question.user.username, answers_count: question.answers.count})}
	end
	# POST Crea una nueva pregunta con los datos provistos en la petición. 
	def create
		@question = current_user.questions.new(question_params)
		if @question.save
			render json: @question, status: :created
		else
			render json: @question.errors, status: :unprocessable_entity
		end
	end

	def update
		if current_user.present?
			@question =  Question.find(params[:id])
		else
			@question = current_user.questions.find(params[:id])
		end

		if @question.update(question_params)
			render json: @question
		else
			render json: @question.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@question = current_user ? Question.find(params[:id]) : current_user.questions.find(params[:id])
		@question.destroy
	end
	
	def show
		render json: @question.attributes.merge({author: @question.user.username })
	end

	private

	def set_question
		@question = Question.find(params[:id])
	end

   def question_params
   	params.permit(
   		:title,
   		:description
   		)
   end
end
