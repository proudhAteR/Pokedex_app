
import SwiftUI

struct InfosView: View {
	let pokemon: Pokemon
	var detail : Bool = false
	var body: some View {
		var heart: String {
			if pokemon.isFavorite {
				return "heart.fill"
			}
			return "heart"
		}
		VStack(alignment: .leading, spacing: 6) {
			HStack {
				Text("#\(PokedexService().formatId(id: pokemon.id))")
					.font(detail ? .subheadline : .caption)
					.foregroundColor(.black)
					.fontWeight(.bold)
				FavoriteView(heart: heart)
				Spacer()
			}
			Text(pokemon.name)
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(.white)

			HStack {
				ForEach(pokemon.types, id: \.self) { type in
					TypeView(type: type)
				}
			}
		}
	}
}

// FavoriteView: Displays a heart icon for favorite Pokémon
struct FavoriteView: View {
	let heart: String
	var body: some View {
		Image(systemName: heart)
			.foregroundColor(.red)
	}
}

