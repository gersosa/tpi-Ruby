class QuestionController < ApplicationController
	before_action :require_login, except: [:index, :show, :answers]
	before_action :set_question, except: [:index, :answers, :answer_in, :answer_out]

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

	def answers
		begin	
			@question = Question.find(params[:question_id])
			render json: @question.answers.map { |answer| {content: answer.content, created: answer.created_at}}
		rescue
			render_unauthorized("Couldn't find Question with id")
		end
	end

	def answer_in
		begin	
			@question = Question.find(params[:question_id])
			if not @question.status
				@answer = @question.answers.new(params[:content], current_user)
				@answer.user_id = current_user.id
				if @answer.save
		      render json: @answer, status: :created
		    else
		      render json: @answer.errors, status: :unprocessable_entity
		    end
			else
				render json: 'Question resolved',status: :unprocessable_entity
			end
		rescue
			render_unauthorized("Couldn't find Question with id")
		end
	end

	def answer_out
		@answer = Answer.find(params[:id])
		@question = Question.find(params[:question_id])
		if current_user.id == @answer.user_id
			if @question.answer_id != @answer.id
				@answer.destroy
			else
				render_unauthorized('You cant remove this answer but is selected')
			end
		else
			render_unauthorized('You cant remove this answer')
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
