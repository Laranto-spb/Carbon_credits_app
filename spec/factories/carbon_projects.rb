FactoryBot.define do
  factory :carbon_project do
    sequence(:project_id) { |n| "PROJ-#{n.to_s.rjust(6, '0')}" }

    name { "Carbon Project #{rand(1000..9999)}" }
    country { [ "Brazil", "USA", "Germany", "India", "Japan", "Canada" ].sample }
    region { [ "South America", "North America", "Europe", "Asia", "Africa" ].sample }
    registry { [ "Verra", "Gold Standard", "CDM" ].sample }

    crediting_period_start { Date.today - 2.years }
    crediting_period_end { Date.today + 5.years }
    methodology { "Avoided Deforestation" }
    project_developer { "EcoDev Solutions" }
    validator { "GreenAudit Inc." }
    status { [ "active", "pending", "archived", "verified" ].sample }
    total_credits_issued { rand(100..10_000).to_d }
  end
end
