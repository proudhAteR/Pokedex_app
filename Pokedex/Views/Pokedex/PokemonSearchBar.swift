import SwiftUI

struct PokemonSearchBar: View {
	@ObservedObject var viewModel = PokemonListViewModel()
	@Binding var query: String
	@Binding var pokemons: [Pokemon]
	@Binding var allPokemons: [Pokemon]
	@Binding var favsOnly : Bool
	@Binding var desc : Bool
	@State var isPresented = false
	private func makeSearch() {
		favsOnly = false
		desc = false
		Task {
			pokemons = await viewModel.handleSearch(query: query)
		}
	}

	var body: some View {
		HStack(spacing: 12) {
			Button(action: {
				makeSearch()
			}) {
				Image(systemName: "magnifyingglass")
					.foregroundColor(.primary)
			}

			TextField(LocalizedStringKey("search_placeholder"), text: $query)
				.textInputAutocapitalization(.none)
				.foregroundColor(.primary)
				.padding(.vertical, 10)
				.padding(.horizontal, 5)
				.onSubmit {
					makeSearch()
				}

			Button(action: {
				isPresented = true
			}) {
				Image(systemName: "qrcode.viewfinder")
					.foregroundColor(.primary)
			}
			.sheet(isPresented: $isPresented, onDismiss: {
				makeSearch()}){
				ScannerViewRepresentable(scanningRes: $query)
			}
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 10)
		.background(Color(.systemGray6))
		.cornerRadius(16)
		.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
	}
}
#Preview {
	PokemonListView()
}
