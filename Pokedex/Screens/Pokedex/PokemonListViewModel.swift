import Foundation

// NOTE: Un ViewModel peut simplifier le code
class PokemonListViewModel: ObservableObject {
	@Published private var favs = false
	@Published private var desc = false
	@Published private var selectedTypes: Set<PokemonType> = []
	var pokemons : [Pokemon] = []
	private let service = PokedexService()
	
	
	func getPokemons() async -> [Pokemon] {
		if pokemons.isEmpty{
			pokemons = await service.fetchPokemon()
		}
		return pokemons
	}
	func handleSearch(query : String) async -> [Pokemon]{
		if query.isEmpty{
			return await getPokemons()
		}
		return service.search(
			pokemons: await getPokemons(),
				   query: query
					   .trimmingCharacters(in: .whitespacesAndNewlines)
			   )
	}
	
	func favorites(desc: Bool, favsOnly: Bool, pokemons: [Pokemon]) async -> [Pokemon] {
		let list = favsOnly ? service.getFavorites(pokemons: pokemons) :
		await getPokemons()
		return await sort(desc: desc, pokemons: list)
	}
	
	func sort(desc: Bool, pokemons: [Pokemon]) async -> [Pokemon] {
			return desc ?
				service.sortDesc(pokemons: pokemons) :
				service.sortAsc(pokemons: pokemons)
	}
	func typeSort(type : PokemonType, pokemons: [Pokemon]) async -> [Pokemon] {
			return desc ?
				service.sortDesc(pokemons: pokemons) :
				service.sortAsc(pokemons: pokemons)
	}

	public func toggle(type: PokemonType) {
		if selectedTypes.contains(type) {
			selectedTypes.remove(type)
		} else {
			selectedTypes.insert(type)
		}
	}
	
	func typeFilter() async -> [Pokemon] {
		var temp: [Pokemon] = []
		if !selectedTypes.isEmpty {
			for pokemon in pokemons {
				if selectedTypes.contains(where: { pokemon.types.contains($0.rawValue) }) {
					temp.append(pokemon)
				}
			}
			return temp
		}
		return await getPokemons()
	}

	
	func getFavs()-> Bool{
		return self.favs
	}
	
	func getDesc()-> Bool{
		return self.desc
	}
	
	func setFavs(value : Bool) {
		favs = value
	}
	
	func setDesc(value : Bool) {
		desc = value
	}
	func getSelectedTypes() -> Set<PokemonType>{
		return selectedTypes
	}
	func emptySelectedTypes(){
		selectedTypes = []
	}
}
