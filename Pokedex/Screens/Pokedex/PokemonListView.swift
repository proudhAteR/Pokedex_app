import SwiftUI

struct PokemonListView: View {
	@EnvironmentObject var viewModel : PokemonListViewModel
	@State private var allPokemons: [Pokemon] = []
	@State private var pokemons: [Pokemon] = []
	@State private var query: String = ""
	@State private var showAlert: Bool = false
	@State private var didInit = false
	@State private var isPresented = false

	private func initView() async {

		if allPokemons.isEmpty {
			allPokemons = await viewModel.getPokemons()
			pokemons = allPokemons
			didInit = true
		}
	}

	private func displayPokemons() -> some View {
		ForEach(pokemons) { pokemon in
			NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
				PokemonView(pokemon: pokemon).id(pokemon.id)
			}
		}
	}

	var body: some View {
		NavigationStack {
			ScrollView {
				PokemonSearchBar(
					query: $query,
					pokemons: $pokemons,
					allPokemons: $allPokemons
				)
				.padding(.top, 16)
				
				VStack(spacing: 8) {
					if !pokemons.isEmpty {
						displayPokemons()
					} else {
						NoPokemonView(didInit: didInit)
					}
				}
				.animation(.easeInOut(duration: 0.2), value: pokemons)
				.onAppear {
					Task {
						await initView()
					}
				}
				.padding(.top, 16)
			}
			.padding(.horizontal, 12)
			.navigationTitle(LocalizedStringKey("app_name"))
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Menu {
						CustomMenuButton(
							action: {
								viewModel.setDesc(value: !viewModel.getDesc())
								Task {
									pokemons = await viewModel.sort(
										desc: viewModel.getDesc(),
										pokemons: pokemons
									)
								}
							},
							label: String(format: "By ID (%@)", viewModel.getDesc() ? "Ascending" : "Descending"),
							image: viewModel.getDesc() ? "arrow.up" : "arrow.down"
						)
						
						CustomMenuButton(
							action: {
								viewModel.setFavs(value: !viewModel.getFavs())
								Task {
									pokemons = await viewModel.favorites(
										desc: viewModel.getDesc(),
										favsOnly: viewModel.getFavs(),
										pokemons: pokemons
									)
								}
							},
							label: viewModel.getFavs() ? "All pokemons" : "Favorites only",
							image: !viewModel.getFavs() ? "heart.fill" : "heart"
						)
						
						CustomMenuButton(action: {
							isPresented = true
						}, label: "Filter by type", image: "number")
					} label: {
						Image(systemName: "slider.horizontal.3")
							.foregroundStyle(.black)
					}
					.sheet(isPresented: $isPresented, onDismiss: {
						Task {
							viewModel.setDesc(value: false)
							viewModel.setFavs(value: false)
							
							pokemons = await viewModel.typeFilter()
						}
					}) {
						NavigationView {
							FilterView()
						}
					}

				}
			}
		}
	}
}

#Preview {
	PokemonListView()
		.environment(\.locale, .init(identifier: "en"))
		.environmentObject(PokemonListViewModel())
}

struct NoPokemonView: View {
	let didInit: Bool

	var body: some View {
		if didInit {
			Text("No Pokémon Found")
				.font(.callout)
				.foregroundStyle(Color.accentColor)
				.bold()
		} else {
			ProgressView()
		}
	}
}
