import SwiftUI

struct PokemonListView: View {
	@ObservedObject var viewModel = PokemonListViewModel()
	@State private var allPokemons: [Pokemon] = []
	@State private var pokemons: [Pokemon] = []
	@State private var query: String = ""
	@State private var showAlert: Bool = false
	@State private var favsOnly = false
	@State private var desc = false

	private func initView() async {
		if allPokemons.isEmpty {
			allPokemons = await viewModel.getPokemons()
			pokemons = allPokemons
		}
	}

	var body: some View {
		NavigationView {
			VStack(spacing: 16) {
				ScrollView {
					PokemonSearchBar(
						query: $query,
						pokemons: $pokemons,
						allPokemons: $allPokemons,
						favsOnly: $favsOnly, desc: $desc
					)
					.padding(.top, 16)
					.onChange(of: pokemons) {
						if pokemons.isEmpty {
							showAlert = true
						}
					}

					LazyVStack(spacing: 8) {
						ForEach(pokemons) { pokemon in
							NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
								PokemonView(pokemon: pokemon).id(pokemon.id)
							}
						}
					}
					.padding(.top, 16)
					.animation(.easeInOut(duration: 0.3), value: pokemons)
				}
			}
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
			.onAppear {
				Task {
					await initView()
				}
			}
			.alert(isPresented: $showAlert) {
				Alert(
					title: Text("No Pokémon Found"),
					message: Text("We couldn't find any Pokémon matching your search."),
					dismissButton: .default(Text("OK"), action: {
						query = ""
						pokemons = allPokemons
						favsOnly = false
						desc = false
					})
				)
			}
		}
	}
}

#Preview {
	PokemonListView()
}

