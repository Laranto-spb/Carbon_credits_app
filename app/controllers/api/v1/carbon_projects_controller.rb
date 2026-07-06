class Api::V1::CarbonProjectsController < ApplicationController
    def index
      Rails.logger.info "=== CACHE STORE CLASS: #{Rails.cache.class} ==="
      Rails.logger.info "=== REDIS URL: #{ENV['REDIS_URL']} ==="

      country = params[:country]
      project_type = params[:type]
      page = (params[:page] || 1).to_i
      per_page = [ (params[:per_page] || 20).to_i, 100 ].min

      cache_key_parts = [
        "carbon:projects:list",
        country,
        project_type,
        page,
        per_page
      ].compact

      cache_key = cache_key_parts.join(":")

      paginated_projects = Rails.cache.fetch(cache_key, expires_in: 3.minutes) do
        query = CarbonProject.all
        query = query.where(country: country) if country.present?
        query = query.where(project_type: project_type) if project_type.present?

        query.offset((page - 1) * per_page).limit(per_page)
      end

      render json: {
        data: paginated_projects.as_json(except: %i[created_at updated_at]),
        meta: {
          page: page,
          per_page: per_page,
          total: CarbonProject.count
        }
      }
    end

    def show
      cache_key = "carbon:project:#{params[:id]}"
      project = Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
        CarbonProject.find(params[:id])
      end
      render json: { data: project.as_json }
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Not found" }, status: :not_found
    end
end
