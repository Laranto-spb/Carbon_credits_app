class CarbonProjectsController < ApplicationController
  DEFAULT_PER_PAGE = 20
  MAX_PER_PAGE     = 100

  def index
    country  = params[:country]
    status   = params[:status]
    page     = params[:page]
    per_page = params[:per_page]
    sort_by  = params[:sort_by]
    sort_order = params[:sort_order]

    cache_key_parts = [
      "carbon:projects:html:list",
      country,
      status,
      page,
      per_page,
      sort_by,
      sort_order
    ].compact

    cache_key = cache_key_parts.join(":")

    @projects, @total = Rails.cache.fetch(cache_key, expires_in: 3.minutes) do
      CarbonRegistry::CarbonProjectsQuery.new(
        country: country,
        status: status,
        page: page,
        per_page: per_page,
        sort_by: sort_by,
        sort_order: sort_order
      ).call
    end

    @page       = [ page.to_i, 1 ].max
    @per_page   = [ [ per_page.to_i, MAX_PER_PAGE ].min, 1 ].max
    @total_pages = (@total.to_f / @per_page).ceil

    render :index
  end
end
