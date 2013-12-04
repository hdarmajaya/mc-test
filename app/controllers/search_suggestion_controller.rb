class SearchSuggestionController < ApplicationController
  def index
    #render json: %w[foo bar]
    render json: GgsnCounter.terms_for(params[:term])
  end
end
