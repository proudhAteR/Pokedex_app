import Foundation

// NOTE: Un ViewModel peut simplifier le code
class PokemonListViewModel: ObservableObject {
	var pokemons : [Pokemon] = [];
	private let service = PokedexService()

	
	func getPokemons() async -> [Pokemon] {
		pokemons = await service.fetchPokemon()
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
}
