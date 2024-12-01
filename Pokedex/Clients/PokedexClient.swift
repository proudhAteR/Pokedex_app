
import Foundation
import SwiftUI

class PokedexClient{
	private let base_url = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons"
	let languageCode = Locale.current.language.languageCode?.identifier ?? "fr"

	func getPokemons() async throws -> [Pokemon] {
		let url = "\(base_url)?limit=151&lang=\(languageCode)"
		let listing: PokemonListing = try await ApiClient.shared.get(apiUrl: url)
		return listing.results
	}
	
	func getDetails (id : Int) async throws -> Details{
		let url = "\(base_url)/\(id)?lang=\(languageCode)"
		
		return try await ApiClient.shared.get(apiUrl: url)
	}
	

	func getImage(url : String) ->  some View{
		return AsyncImage(url: URL(string: url)) { phase in
			switch phase {
				case .empty:
					ProgressView()
						.scaledToFit()
				case .success(let image):
					image
						.resizable()
						.scaledToFit()
				case .failure:
					Image(.pokeball)
						.resizable()
						.scaledToFit()
				@unknown default:
					Image(.pokeball)
						.resizable()
						.scaledToFit()
			}
		}
	}
}
