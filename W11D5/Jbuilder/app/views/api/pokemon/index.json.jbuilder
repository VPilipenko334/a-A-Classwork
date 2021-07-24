@pokemons.each do |poke|
  json.set! poke.id do
    json.extract! poke, :id, :name  #invoke methods to grab info
    json.image_url asset_path("pokemon_snaps/#{poke.image_url}")
  end
end

