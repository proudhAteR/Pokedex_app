import SwiftUI

class ScannerViewModel: ObservableObject {
	@Published var scannedCode: String = ""
	var pokedex = PokemonListViewModel()
	
	func goTo() async {
		pokedex.pokemons = await pokedex.handleSearch(query: scannedCode)
		print(pokedex.pokemons)
	}
}
