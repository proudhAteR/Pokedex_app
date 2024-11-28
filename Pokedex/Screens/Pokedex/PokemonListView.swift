import SwiftUI

// PokemonListView: Display a list of Pokemons from API
struct PokemonListView: View {
	@ObservedObject var viewModel = PokemonListViewModel()
	@State private var allPokemons: [Pokemon] = []
	@State private var pokemons: [Pokemon] = []
	@State private var query : String = ""
	private func initView() async {
		if allPokemons.isEmpty {
			allPokemons = await viewModel.getPokemons()
			pokemons = allPokemons
		}
	}
	
	var body: some View {
		
		NavigationView {
			VStack(spacing: 16)  {
				ScrollView {
					PokemonSearchBar(
						query: $query,
						pokemons: $pokemons,
						allPokemons: $allPokemons
					)
						.padding(.top, 16)
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
											PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.45),
											PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.75)
										]),
										startPoint: .top,
										endPoint: .bottom
									)
								)
								.cornerRadius(20)
								.padding(.vertical, 10)
								.shadow(color: PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.5), radius: 4, y: 8)
								
							}
						}
					}
					.padding(.top, 16)
					.frame(width: .infinity)
					.ignoresSafeArea(.all)
				}
			}
			.padding(.horizontal, 12)
			.navigationTitle(LocalizedStringKey("app_name"))
		}

		.onAppear {
			Task{
				await initView()
			}
		}
			
		}
	}


#Preview {
	PokemonListView()
}


struct PokemonRowView: View {
	var pokemon: Pokemon
	var body: some View {
		HStack(spacing: 8) {
			InfosView(pokemon: pokemon)
			Spacer()
			PokedexService().getImage(id: pokemon.id)
				.frame(width: 132)
		
		}
	}
}

