class ApplicationController < ActionController::API
	before_action :authenticate_request 
	attr_reader :current_user
	before_filter :allow_ajax_request_from_other_domains 
	
	def allow_ajax_request_from_other_domains
   	  headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = '*'
    end

	private 
	def authenticate_request 
		headers['Access-Control-Allow-Origin'] = "*"
		@current_user = AuthorizeApiRequest.call(request.headers).result 
		render json: { error: 'Not Authorized' }, status: 401 unless @current_user 
	end
end
