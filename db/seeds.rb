puts "🌱 Seeding carbon projects (demo data)..."

CarbonProject.destroy_all

projects = [
  {
    name: "Solar Farm Alpha", country: "DE", region: "Bavaria",
    registry: "Verified Carbon Standard", project_id: "VC-DE-SOL-001",
    status: "active", methodology: "ACM0002", validator: "SGS",
    crediting_period_start: 36.months.ago.to_date,
    crediting_period_end: 84.months.from_now.to_date,
    total_credits_issued: 1500.0, last_synced_at: 2.days.ago
  },
  {
    name: "Wind Park Beta", country: "US", region: "Texas",
    registry: "Gold Standard", project_id: "GS-US-WND-002",
    status: "active", methodology: "AMS-III.D", validator: "Bureau Veritas",
    crediting_period_start: 48.months.ago.to_date,
    crediting_period_end: 72.months.from_now.to_date,
    total_credits_issued: 3200.5, last_synced_at: 1.day.ago
  },
  {
    name: "Biomass Station Gamma", country: "BR", region: "São Paulo",
    registry: "VCS", project_id: "VCS-BR-BIO-003",
    status: "paused", methodology: "ACM0007", validator: "DNV",
    crediting_period_start: 24.months.ago.to_date,
    crediting_period_end: 60.months.from_now.to_date,
    total_credits_issued: 800.25, last_synced_at: 5.days.ago
  },
  {
    name: "Hydro Plant Delta", country: "CA", region: "British Columbia",
    registry: "CDM", project_id: "CDM-CA-HYD-004",
    status: "active", methodology: "AM0001", validator: "TÜV SÜD",
    crediting_period_start: 60.months.ago.to_date,
    crediting_period_end: 96.months.from_now.to_date,
    total_credits_issued: 2100.75, last_synced_at: 3.hours.ago
  },
  {
    name: "Geothermal Site Epsilon", country: "KE", region: "Rift Valley",
    registry: "Gold Standard", project_id: "GS-KE-GEO-005",
    status: "pending", methodology: "ACM0015", validator: "SGS",
    crediting_period_start: 12.months.ago.to_date,
    crediting_period_end: 120.months.from_now.to_date,
    total_credits_issued: 450.1, last_synced_at: nil
  },
  {
    name: "Offshore Wind Farm Zeta", country: "UK", region: "North Sea",
    registry: "UK Carbon Registry", project_id: "UK-UK-OWF-006",
    status: "active", methodology: "ACM0045", validator: "Lloyd's Register",
    crediting_period_start: 12.months.ago.to_date,
    crediting_period_end: 144.months.from_now.to_date,
    total_credits_issued: 5000.0, last_synced_at: 4.hours.ago
  },
  {
    name: "Forest Conservation Omega", country: "PE", region: "Amazonas",
    registry: "Verra REDD+", project_id: "REDD-PE-FOR-007",
    status: "active", methodology: "VM0005", validator: "Control Union",
    crediting_period_start: 6.months.ago.to_date,
    crediting_period_end: 240.months.from_now.to_date,
    total_credits_issued: 12000.0, last_synced_at: 1.day.ago
  },
  {
    name: "Landfill Gas Capture Theta", country: "IN", region: "Maharashtra",
    registry: "India Carbon Market", project_id: "IND-IN-LFG-008",
    status: "paused", methodology: "ACM0009", validator: "Bureau Veritas",
    crediting_period_start: 36.months.ago.to_date,
    crediting_period_end: 84.months.from_now.to_date,
    total_credits_issued: 950.5, last_synced_at: 7.days.ago
  },
  {
    name: "Small Hydro Cluster Iota", country: "NP", region: "Gandaki",
    registry: "Nepal Carbon Scheme", project_id: "NEP-NP-SHC-009",
    status: "active", methodology: "AM0012", validator: "DNV",
    crediting_period_start: 30.months.ago.to_date,
    crediting_period_end: 180.months.from_now.to_date,
    total_credits_issued: 340.2, last_synced_at: 2.days.ago
  },
  {
    name: "Urban Tree Planting Kappa", country: "SG", region: "Central Region",
    registry: "Singapore Green Credits", project_id: "SG-SG-UTP-010",
    status: "pending", methodology: "ACM0050", validator: "SGS",
    crediting_period_start: Date.today,
    crediting_period_end: 120.months.from_now.to_date,
    total_credits_issued: 150.0, last_synced_at: nil
  },
  {
    name: "Methane Capture Lambda", country: "RU", region: "Yamalo-Nenets",
    registry: "Russian Carbon Registry", project_id: "RU-RU-MC-011",
    status: "active", methodology: "ACM0023", validator: "Gazprom Certification",
    crediting_period_start: 18.months.ago.to_date,
    crediting_period_end: 300.months.from_now.to_date,
    total_credits_issued: 7800.3, last_synced_at: 6.hours.ago
  },
  {
    name: "Tidal Energy Mu", country: "FR", region: "Brittany",
    registry: "French Ocean Energy", project_id: "FR-FR-TID-012",
    status: "active", methodology: "ACM0031", validator: "Bureau Veritas",
    crediting_period_start: 8.months.ago.to_date,
    crediting_period_end: 360.months.from_now.to_date,
    total_credits_issued: 2300.8, last_synced_at: 1.day.ago
  },
  {
    name: "Waste-to-Energy Nu", country: "JP", region: "Kanto",
    registry: "Japan Voluntary Credits", project_id: "JP-JP-WTE-013",
    status: "paused", methodology: "ACM0018", validator: "TÜV SÜD",
    crediting_period_start: 48.months.ago.to_date,
    crediting_period_end: 120.months.from_now.to_date,
    total_credits_issued: 1100.4, last_synced_at: 3.days.ago
  },
  {
    name: "Afforestation Xi", country: "ZA", region: "Eastern Cape",
    registry: "South African Carbon Fund", project_id: "SA-ZA-AFF-014",
    status: "active", methodology: "VM0047", validator: "Control Union",
    crediting_period_start: 12.months.ago.to_date,
    crediting_period_end: 240.months.from_now.to_date,
    total_credits_issued: 6700.9, last_synced_at: 2.hours.ago
  },
  {
    name: "Blue Carbon Omicron", country: "AU", region: "Queensland",
    registry: "Australian Blue Carbon", project_id: "AU-AU-BC-015",
    status: "pending", methodology: "ACM0060", validator: "SGS",
    crediting_period_start: Date.tomorrow,
    crediting_period_end: 300.months.from_now.to_date,
    total_credits_issued: 3100.2, last_synced_at: nil
  }
]

count = 0
projects.each do |attrs|
  begin
    CarbonProject.create!(attrs)
    count += 1
  rescue ActiveRecord::RecordInvalid => e
    puts "⚠️ Failed to create project #{attrs[:name]}: #{e.message}"
  end
end

puts "✅ Created #{count} projects."
