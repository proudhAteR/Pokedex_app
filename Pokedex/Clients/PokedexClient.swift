
import Foundation
import SwiftUI

class PokedexClient{
	@Environment(\.locale) var locale
	private let base_url = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons?"
	
	func getPokemons() async throws -> [Pokemon] {
		let languageCode = Locale.current.language.languageCode?.identifier ?? "fr"
		let url = "\(base_url)limit=151&lang=\(languageCode)"
		let listing: PokemonListing = try await ApiClient.shared.get(apiUrl: url)
		
		return listing.results
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
					ProgressView()
						.scaledToFit()
				@unknown default:
					ProgressView()
						.scaledToFit()
			}
		}
	}
}
