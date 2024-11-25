import SwiftUI

// PokemonListView: Display a list of Pokemons from API
struct PokemonListView: View {
	private let service = PokedexService()
	@State private var pokemons: [Pokemon] = []
	
	var body: some View {
		NavigationView {
			VStack {
				ScrollView {
					LazyVStack(spacing: 8) {
						ForEach(pokemons) { pokemon in
							NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
								HStack {
									PokemonRowView(pokemon: pokemon)
										.padding()
								}
								.background(
									LinearGradient(
										gradient: Gradient(colors: [
											PokemonType(rawValue: pokemon.types.first!)!.color.opacity(0.45),
											PokemonType(rawValue: pokemon.types.first!)!.color.opacity(0.75)
										]),
										startPoint: .top,
										endPoint: .bottom
									)
								)
								.cornerRadius(20)
								.padding(.horizontal, 16)
								.padding(.vertical, 10)
							}
						}
					}
					.padding(.top, 16)
				}
			}
			.navigationTitle(Text("app_name")) // Navigation title
		}



			.onAppear {
				Task {
					pokemons = await service.fetchPokemon()
				}
			}
			
		}
	}


#Preview {
	PokemonListView()
}

struct TypeAsString: View {
	var type: String
	var body: some View {
		Text(type.capitalized)
			.font(.caption)
	}
}

struct TypeView: View {
	var type: String
	var body: some View {
		let localizedTypeName = PokedexService().localizedType(for: type)
		HStack {
			Image(PokemonType(rawValue: type)!.image)
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20, alignment: .center)
			TypeAsString(type: localizedTypeName)
			
		}
		.lineLimit(1)
		.padding(.horizontal, 4)
		.padding(.vertical, 6)
		.background(PokemonType(rawValue: type)!.color)
		.foregroundColor(.white)
		.cornerRadius(4)
	}
}

// PokemonInfoView: Displays basic Pokémon information in the list
struct PokemonRowView: View {
	var pokemon: Pokemon
	var body: some View {
		HStack(spacing: 16) {
			InfosView(pokemon: pokemon)
			Spacer()
			PokedexService().getImage(id: pokemon.id)
				.frame(width: 132)
		
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

// InfosView: Displays detailed Pokémon info such as ID and type
struct InfosView: View {
	let pokemon: Pokemon
	var body: some View {
		var heart: String {
			if pokemon.isFavorite {
				return "heart.fill"
			}
			return "heart"
		}
		VStack(alignment: .leading, spacing: 4) {
			HStack {
				Text("#\(PokedexService().formatId(id: pokemon.id))")
					.font(.caption)
					.foregroundColor(.black)
					.bold()
				FavoriteView(heart: heart)
				Spacer()
			}
			Text(pokemon.name)
				.font(.title3)
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

