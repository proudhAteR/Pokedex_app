import SwiftUI

struct PokemonListView: View {
	@ObservedObject var viewModel = PokemonListViewModel()
	@State private var allPokemons: [Pokemon] = []
	@State private var pokemons: [Pokemon] = []
	@State private var query: String = ""
	@State private var showAlert: Bool = false
	@State private var favsOnly = false
	@State private var desc = false
	@State private var didInit = false
	private func initView() async {
		if allPokemons.isEmpty {
			allPokemons = await viewModel.getPokemons()
			pokemons = allPokemons
			didInit = true

		}
	}

	private func displayPokemons() -> ForEach<[Pokemon], Int, NavigationLink<some View, PokemonDetailView>> {
		return ForEach(pokemons) { pokemon in
			NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
				PokemonView(pokemon: pokemon).id(pokemon.id)
			}
		}
	}
	
	var body: some View {
		NavigationStack {
			ScrollView {
			VStack(spacing: 16) {
					PokemonSearchBar(
						query: $query,
						pokemons: $pokemons,
						allPokemons: $allPokemons,
						favsOnly: $favsOnly, desc: $desc
					)
					.padding(.top, 16)
					LazyVStack(spacing: 8) {
						if !pokemons.isEmpty {
							displayPokemons()
						}else{
							NoPokemonView(didInit: didInit)
						}
					}
					.onAppear {
						Task {
							await initView()
						}
					}
					.padding(.top, 16)
				}
			}
			.animation(.easeInOut(duration: 0.2), value: pokemons)
			.padding(.horizontal, 12)
			.navigationTitle(LocalizedStringKey("app_name"))
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Menu {
						Button {
							desc.toggle()
							Task {
								pokemons = await viewModel
									.sort(
										desc: desc,
										pokemons: pokemons
									)
							}
						} label: {
							HStack {
								Text(String(format: "By ID (%@)", desc ? "Ascending" : "Descending"))
								Spacer()
								Image(systemName: desc ? "arrow.up" : "arrow.down")
							}
							.padding()
							.cornerRadius(8)
						}

						Button {
							favsOnly.toggle()
							Task {
								pokemons = await viewModel
									.favorites(desc: desc, favsOnly: favsOnly, pokemons: pokemons)
							}
						} label: {
							HStack {
								Text(favsOnly ? "All pokemons" : "Favorites only")
								Spacer()
								Image(systemName: !favsOnly ? "heart.fill" : "heart")
							}
							.padding()
							.cornerRadius(8)
						}

						Button("Filter by type") {
							print("Filter option selected")
						}
					} label: {
						Image(systemName: "slider.horizontal.3")
							.foregroundStyle(.black)
					}
				}
			}
			
		}
	}
}

#Preview {
	PokemonListView()
}
struct NoPokemonView: View {
	let didInit: Bool

	var body: some View {
		if didInit {
			Text("No Pokémon Found")
				.font(.callout)
				.foregroundStyle(Color.accentColor)
				.bold()
		}
	}
}
