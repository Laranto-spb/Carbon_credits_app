namespace :carbon do
  desc "Seeds demo projects"
  task generate_demo_data: :environment do
    puts "🌳 Seeding Carbon Projects..."
    CarbonProject.delete_all

    countries = %w[Brazil India China USA Germany Kenya Indonesia]
    types = %w[Forestry Energy Waste Agriculture Renewable_Energy]
    names = [
      "Amazon Reforestation Initiative",
      "Solar Farms Expansion in Rajasthan",
      "Biogas from Agricultural Waste",
      "Wind Power Park in Texas",
      "Mangrove Restoration in Indonesia",
      "Geothermal Energy Project in Kenya",
      "Urban Greening and Tree Planting",
      "Energy Efficiency Retrofit Program"
    ]

    names.each_with_index do |name, i|
      registry_id = "SEED-#{i + 1}-#{name.gsub(/\W+/, '').upcase[0, 10]}"

      CarbonProject.find_or_create_by!(registry_id: registry_id) do |project|
        project.name = name
        project.country = countries[i % countries.size]
        project.project_type = types[i % types.size]
        project.total_co2e_tons = rand(1500..8500)
        project.status = [ "active", "verified", "pending" ].sample
        project.start_date = Date.today - rand(30..365).days
      end
    end

    puts "✅ Done! Created #{CarbonProject.count} projects."
  end
end
