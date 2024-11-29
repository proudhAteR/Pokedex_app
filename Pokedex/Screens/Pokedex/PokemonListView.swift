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
								PokemonView(pokemon: pokemon)
							}
						}
					}
					.padding(.top, 16)
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

