class CarbonProjectsController < ApplicationController
  DEFAULT_PER_PAGE = 20
  MAX_PER_PAGE     = 100

  def index
    country = params[:country]
    status  = params[:status]
    page    = [ (params[:page] || 1).to_i, 1 ].max
    per_page = [ (params[:per_page] || DEFAULT_PER_PAGE).to_i, MAX_PER_PAGE ].min

    cache_key_parts = [
      "carbon:projects:html:list",
      country,
      status,
      page,
      per_page
    ].compact

    cache_key = cache_key_parts.join(":")

    @projects, @total = Rails.cache.fetch(cache_key, expires_in: 3.minutes) do
      query = CarbonProject.all
      query = query.where(country: country) if country.present?
      query = query.where(status: status)    if status.present?

      total = query.count
      records = query.offset((page - 1) * per_page).limit(per_page)

      [ records, total ]
    end

    @page     = page
    @per_page = per_page
    @total_pages = (@total.to_f / @per_page).ceil

    render :index
  end
end
