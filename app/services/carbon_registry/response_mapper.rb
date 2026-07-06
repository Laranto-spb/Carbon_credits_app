module CarbonRegistry
  class ResponseMapper
    def self.to_project_params(raw)
      return nil unless raw.is_a?(Hash)

      {
        project_id:           raw.dig("project_id"),
        registry:             raw.dig("registry"),
        name:                 raw.dig("project_name"),
        methodology:          raw.dig("methodology"),
        country:              raw.dig("country"),
        region:               raw.dig("region"),
        project_developer:    raw.dig("project_developer"),
        validator:            raw.dig("validator"),
        status:               raw.dig("status"),
        crediting_period_start: parse_date(raw.dig("crediting_period_start")),
        crediting_period_end:   parse_date(raw.dig("crediting_period_end")),
        total_credits_issued:  (raw.dig("total_credits_issued") || 0).to_d,
        last_synced_at:        Time.current
      }
    end

    private

    def self.parse_date(value)
      return nil if value.blank?
      Date.parse(value) rescue nil
    end
  end
end
