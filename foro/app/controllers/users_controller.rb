class UsersController < ApplicationController

   # POST Crea un nuevo usuario con los datos provistos en la petición. 
   def register
   	@user = User.create(user_params)
   	if @user.save
   		response = { message: 'User created successfully'}
   		render json: response, status: 201 
   	else
         response = { message: @user.errors.to_a.join(' ')}
   		render json: response, status: 422
   	end 
   end

   private

   def user_params
   	params.permit(
   		:username,
   		:screen_name,
   		:email,
   		:password
   		)
   end
end
