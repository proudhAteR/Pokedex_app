import SwiftUI

struct PokemonSearchBar: View {
	@Binding var query: String
	@Binding var pokemons: [Pokemon]
	@Binding var allPokemons: [Pokemon]
	@ObservedObject var viewModel : PokemonListViewModel
	@State var isPresented = false
	private func makeSearch() {
		viewModel.setDesc(value: false)
		viewModel.setFavs(value: false)
		viewModel.emptySelectedTypes()

		Task {
			if query.isEmpty{
				pokemons = allPokemons
			}else{
				pokemons =  await viewModel.handleSearch(query: query)
			}
		}
	}

	var body: some View {
		HStack(spacing: 12) {
			Image(systemName: "magnifyingglass")
				.foregroundColor(.primary)

			TextField(LocalizedStringKey("search_placeholder"), text: $query)
				.textInputAutocapitalization(.none)
				.foregroundColor(.primary)
				.padding(.vertical, 10)
				.padding(.horizontal, 5)
				.disableAutocorrection(true)
				.onChange(of: query) {
					makeSearch()
				}
				.onSubmit {
					makeSearch()
				}

			if query.isEmpty{
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
			}else{
				Button(action: {
					query = ""
					isPresented = false
				}) {
					Image(systemName: "xmark.circle.fill")
						.foregroundColor(.primary)
				}
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
