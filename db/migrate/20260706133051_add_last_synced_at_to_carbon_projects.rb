class AddLastSyncedAtToCarbonProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :carbon_projects, :last_synced_at, :datetime
  end
end
