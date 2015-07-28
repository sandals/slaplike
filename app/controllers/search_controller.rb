require 'uri'

class SearchController < ApplicationController
  def index
  end

  def results
    @search = Search.new(terms: URI.escape(params[:terms]))
  end
end
