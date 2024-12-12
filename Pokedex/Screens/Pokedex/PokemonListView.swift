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
	@State private var isPresented = false
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
					PokemonSearchBar(
						query: $query,
						pokemons: $pokemons,
						allPokemons: $allPokemons,
						favsOnly: $favsOnly, desc: $desc
					)
					.padding(.top, 16)
				VStack(spacing: 8) {
						if !pokemons.isEmpty {
							displayPokemons()
						}else{
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
								desc.toggle()
								Task {
									pokemons = await viewModel.sort(desc: desc, pokemons: pokemons)
								}
							},
							label: String(format: "By ID (%@)", desc ? "Ascending" : "Descending"),
							image: desc ? "arrow.up" : "arrow.down"
						)
						
						CustomMenuButton(
							action: {
								favsOnly.toggle()
								Task {
									pokemons = await viewModel.favorites(desc: desc, favsOnly: favsOnly, pokemons: pokemons)
								}
							},
							label: favsOnly ? "All pokemons" : "Favorites only",
							image: !favsOnly ? "heart.fill" : "heart"
						)
						
						CustomMenuButton(action: {
							isPresented = true
						}, label: "Filter by type", image: "number")
						
					} label: {
						Image(systemName: "slider.horizontal.3")
							.foregroundStyle(.black)
					}
					.sheet(isPresented: $isPresented){
						FilterView()
					}
				}
			}
			
		}
	}
}

#Preview {
	PokemonListView().environment(\.locale, .init(identifier: "fr"))
}
struct NoPokemonView: View {
	let didInit: Bool

	var body: some View {
		if didInit {
			Text("No Pokémon Found")
				.font(.callout)
				.foregroundStyle(Color.accentColor)
				.bold()
		}else{
			ProgressView()
		}
	}
}
struct CustomMenuButton: View {
	let action: () -> Void
	let label: String
	let image: String

	var body: some View {
		Button(action: action) {
			HStack {
				Text(label)
				Spacer()
				Image(systemName: image)
			}
			.padding()
			.cornerRadius(8)
		}
	}
}

struct FilterView: View {
	let columns = [
		GridItem(.flexible(), alignment: .center),
		GridItem(.flexible(), alignment: .center)
	]

	private func filterBy(type: String) {
		print("Filter by \(type)")
	}

	var body: some View {
		LazyVGrid(columns: columns, spacing: 16) {
			ForEach(PokemonType.allCases, id: \.self) { type in
				Button(action: {
					filterBy(type: type.rawValue)
				}) {
					TypeView(type: type.rawValue, filter: true)
						.cornerRadius(8)
				}
			}
		}
		.padding()
	}
}

