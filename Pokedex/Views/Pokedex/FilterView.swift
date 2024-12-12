import SwiftUI

struct FilterView: View {
	@ObservedObject var vm : PokemonListViewModel
	let columns = [
		GridItem(.flexible(), alignment: .center),
		GridItem(.flexible(), alignment: .center)
	]
	@Environment(\.dismiss) private var dismiss

	var body: some View {
		LazyVGrid(columns: columns, spacing: 16) {
			ForEach(PokemonType.allCases, id: \.self) { type in
				Button(action: {
					vm.toggle(type: type)
				}) {
					TypeView(
						type: type.rawValue,
						filter: true,
						selectedTypes: vm.getSelectedTypes()
					)
					.cornerRadius(8)
				}
			}
		}
		.padding()
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					dismiss()
				} label: {
					Image(systemName: "arrowshape.backward.fill")
						.foregroundStyle(.black)
				}
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					vm.emptySelectedTypes()
				} label: {
					Image(systemName: "arrow.trianglehead.counterclockwise")
						.foregroundStyle(.black)
				}
			}
		}
		.navigationTitle("Filter by type")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	@Previewable let vm = PokemonListViewModel()
	FilterView(vm: vm)
}
