import SwiftUI

struct UpgradesView: View {
	@Binding var details : Details?
	@State var evolutions : [Pokemon] = []
	@ObservedObject var viewModel = PokemonDetailViewModel()

    var body: some View {
		ScrollView{
			LazyVStack(spacing: 8) {
				ForEach(evolutions) { evolution in
					NavigationLink(destination: PokemonDetailView(pokemon: evolution)) {
						PokemonView(pokemon: evolution)
							.id(evolution.id)
					}
				}
			}
		}
		.padding()
		.onAppear {
			Task {
				evolutions = await viewModel
					.getEvolution(
						evolutions: details?.evolutions ?? ["Charizard"],
						id: details?.id ?? 1
					)
			}
		}

    }
}
