class CarbonProjectsController < ApplicationController
  def index
    country = params[:country]
    status = params[:status]
    page = (params[:page] || 1).to_i
    per_page = [ (params[:per_page] || 20).to_i, 100 ].min

    cache_key_parts = [
      "carbon:projects:html:list",
      country,
      status,
      page,
      per_page
    ].compact

    cache_key = cache_key_parts.join(":")

    @projects = Rails.cache.fetch(cache_key, expires_in: 3.minutes) do
      query = CarbonProject.all
      query = query.where(country: country) if country.present?
      query = query.where(status: status) if status.present?

      query.offset((page - 1) * per_page).limit(per_page).load
    end

    @page = page
    @per_page = per_page
    @total = CarbonProject.count

    render :index
  end
end
