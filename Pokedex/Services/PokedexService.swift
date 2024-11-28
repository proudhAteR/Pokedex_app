
import Foundation
import SwiftUI

class PokedexService{
	private let client = PokedexClient()
	
	func fetchPokemon()async ->[Pokemon]{
		do {
			let pokemons: [Pokemon] = try await client.getPokemons()
			
			return pokemons
		} catch {
			print("Banana: \(error)")
			return []
		}
	}
	func formatId(id : Int) -> String {
		return String(format: "%03d", id)
	}
	
	func getImage(id: Int) -> some View {
		let url = "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/\(formatId(id: id)).png"
		return client.getImage(url: url)
	}
	func localizedType(for type: String) -> String {
		return NSLocalizedString(type, comment: "Localized Pokemon type")
	}
	
	func search(pokemons : [Pokemon], query : String)-> [Pokemon]{
		return pokemons.filter { pokemon in
			pokemon.name.localizedCaseInsensitiveContains(query)
		}
	}
	
	func fetchDetails(id: Int) async -> Details? {
		do {
			let details = try await client.getDetails(id: id)
			return details
		} catch {
			print("Error fetching details: \(error)")
			return nil 
		}
	}

	
}
