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

    @projects, @total =
      CarbonRegistry::CarbonProjectsQuery.new(
        country: country,
        status: status,
        page: page,
        per_page: per_page,
        sort_by: sort_by,
        sort_order: sort_order
      ).call

    @page       = [ page.to_i, 1 ].max
    @per_page   = [ [ per_page.to_i, MAX_PER_PAGE ].min, 1 ].max
    @total_pages = (@total.to_f / @per_page).ceil

    render :index
  end
end
