class QuestionController < ApplicationController
	before_action :require_login, except: [:index, :show]
	before_action :set_question, except: [:index]

	def index
		if params[:sort]=='pending_first'
			@questions = Question.where('status = ?', false ).first(50)
		else
			@questions = Question.order('created_at DESC').first(50)
		end
		render json: @questions.map { |question| {title: question.title, description: question.description[0,120]+'...'}}
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
		if current_user.id == @question.user_id
			if @question.update(question_params)
				render json: @question
			else
				render json: @question.errors, status: :unprocessable_entity
			end
		else
			render_unauthorized('You cant update this questions')
		end
		
	end

	def destroy
		if current_user.id == @question.user_id && @question.answers.count < 1
			@question.destroy
		else
			render_unauthorized('You cant delete this questions')
		end
	end

	def show
		render json: @question.attributes.merge({author: @question.user.username })
	end

	def resolve
		if current_user.id == @question.user_id
			if Answer.find(params[:answer_id]).question_id == @question.id
				@question.status = true
				@question.answer_id = params[:answer_id]
				@question.save
			end
		else
			render_unauthorized('You cant resolve this questions')
		end		
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
