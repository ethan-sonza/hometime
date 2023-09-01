class ApplicationController < ActionController::API
    before_action :set_json_format

    private

    def set_json_format
        request.headers['Accept'] = 'application/json'
    end
end
