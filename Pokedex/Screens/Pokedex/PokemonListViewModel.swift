import Foundation

// NOTE: Un ViewModel peut simplifier le code
class PokemonListViewModel: ObservableObject {
	var pokemons : [Pokemon] = [];
	private let service = PokedexService()

	
	func getPokemons() async -> [Pokemon] {
		if pokemons.isEmpty{
			pokemons = await service.fetchPokemon()
		}
		return self.pokemons
	}
	func handleSearch(query : String) async -> [Pokemon]{
		pokemons = await query.isEmpty ? await getPokemons() :
		service.search(
			pokemons: getPokemons(),
				   query: query
					   .trimmingCharacters(in: .whitespacesAndNewlines)
			   )
		return pokemons
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
}
