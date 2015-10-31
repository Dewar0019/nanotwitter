class ErrorController < ApplicationController
  not_found do
    status 404
    erb :error
  end
end
