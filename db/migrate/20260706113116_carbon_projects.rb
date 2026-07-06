class CarbonProjects < ActiveRecord::Migration[8.1]
  def change
      create_table :carbon_projects do |t|
        t.string  :project_id, null: false
        t.string  :registry, null: false
        t.string  :name, null: false
        t.string  :methodology
        t.string  :country, null: false
        t.string  :region, null: false
        t.decimal :total_credits_issued, precision: 18, scale: 4
        t.string  :status
        t.date    :crediting_period_start
        t.date    :crediting_period_end
        t.string  :project_developer
        t.string  :validator

        t.timestamps
    end

    add_index :carbon_projects, :project_id, unique: true
    add_index :carbon_projects, [ :country, :status ]
  end
end
