module CarbonRegistry
  class SyncService
    def initialize(limit: 200)
      @limit = limit
    end

    def call
      raw_records = HttpClient.fetch_items(limit: @limit)

      raw_records.each do |raw|
        params = ResponseMapper.to_project_params(raw)
        next unless params && params[:project_id].present?

        project = CarbonProject.find_or_initialize_by(project_id: params[:project_id])
        project.assign_attributes(params)

        unless project.save
          Rails.logger.error(
            "Failed to save #{params[:project_id]}: #{project.errors.full_messages.join(', ')}"
          )
        end
      end
    end
  end
end
