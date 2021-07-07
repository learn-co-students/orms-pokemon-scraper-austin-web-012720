class Scraper
  attr_accessor :file, :parsed_file, :all_pokemon, :db

  def initialize(db)
    self.db = db
    self.file = File.open("pokemon_index.html")
    self.parsed_file = Nokogiri::HTML.parse(file)
    self.all_pokemon = catch_em_all
  end

  def catch_em_all
    self.all_pokemon = parsed_file.css(".infocard-tall")
  end

  def get_pokemon_name_from(node)
    node.css(".ent-name").text
  end

  def get_pokemon_type_from(node)
    node.css(".itype").text
  end

  def scrape
    all_pokemon.each do |pk_node|
      pk_name = get_pokemon_name_from(pk_node)
      pk_type = get_pokemon_type_from(pk_node)
      Pokemon.save(pk_name, pk_type, db)
    end
  end

end


# <span class="infocard-tall ">
  # <a class="pkg  pkgRBY n1" data-sprite=" pkgRBY n1 " href="http://pokemondb.net/pokedex/bulbasaur"></a>
  # <br><small>#001</small>
  # <br><a class="ent-name" href="http://pokemondb.net/pokedex/bulbasaur">Bulbasaur</a>
  # <br><small class="aside">
    # <a href="http://pokemondb.net/type/grass" class="itype grass">Grass</a> · 
    # <a href="http://pokemondb.net/type/poison" class="itype poison">Poison</a>
  # </small>
# </span>
