module CarbonRegistry
  class CarbonProjectsQuery
    DEFAULT_PER_PAGE = 20
    MAX_PER_PAGE     = 100

    ALLOWED_SORT_COLUMNS = %w[total_credits_issued created_at].freeze

    def initialize(country: nil, status: nil, page: 1, per_page: DEFAULT_PER_PAGE, sort_by: nil, sort_order: :asc)
      @country  = country
      @status   = status
      @page     = [ page.to_i, 1 ].max
      @per_page = [ [ per_page.to_i, MAX_PER_PAGE ].min, 1 ].max
      @sort_by  = normalize_sort_column(sort_by)
      @sort_order = normalize_sort_order(sort_order)
    end

    def call
      query = base_query
      total = query.count
      records = apply_pagination(query)

      [ records, total ]
    end

    private

    def base_query
      q = CarbonProject.all
      q = q.where(country: @country) if @country.present?
      q = q.where(status: @status)   if @status.present?
      q = apply_sort(q)
      q
    end

    def apply_sort(query)
      return query unless @sort_by.present?

      order_direction = @sort_order.to_s.downcase == "desc" ? :desc : :asc
      query.order(@sort_by => order_direction)
    end

    def apply_pagination(query)
      offset = (@page - 1) * @per_page
      query.offset(offset).limit(@per_page)
    end

    def normalize_sort_column(value)
      return nil if value.blank?
      column = value.to_s
      ALLOWED_SORT_COLUMNS.include?(column) ? column : nil
    end

    def normalize_sort_order(value)
      order = value.to_s.downcase
      %w[asc desc].include?(order) ? order : "asc"
    end
  end
end
