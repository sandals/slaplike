class SearchController < ApplicationController
  def index
  end

  def results
    @search = Search.new(terms: params[:terms])
  end
end
