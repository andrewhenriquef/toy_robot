FactoryBot.define do
  factory :robot do
    axis_x { rand(0..4) }
    axis_y { rand(0..4) }
    face { %w[NORTH SOUTH EAST WEST].sample }
    association :board, factory: :board
  end
end
