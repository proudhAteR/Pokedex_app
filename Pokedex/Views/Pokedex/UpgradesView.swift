import SwiftUI

struct UpgradesView: View {
	@Binding var details : Details?
	@State var evolutions : [Pokemon] = []
	@ObservedObject var viewModel = PokemonDetailViewModel()
	@State var didInit = false
	private func initView() async {
		evolutions = await viewModel
			.getEvolution(
				evolutions: details?.evolutions ?? ["Charizard"],
				id: details?.id ?? 1
			)
	}
	
	private func displaEvolutions() -> ForEach<[Pokemon], Int, NavigationLink<some View, PokemonDetailView>> {
		return ForEach(evolutions) { evolution in
			NavigationLink(destination: PokemonDetailView(pokemon: evolution)) {
				PokemonView(pokemon: evolution)
					.id(evolution.id)
			}
		}
	}
	
	var body: some View {
		ScrollView{
			LazyVStack(spacing: 8) {
				if !evolutions.isEmpty{
					displaEvolutions()
				}else{
					NoUpgradesView(didInit: didInit)
				}
			}
		}
		.padding()
		.onAppear {
			Task {
				await initView()
				didInit = true
			}
		}

    }
}
struct NoUpgradesView: View {
	let didInit: Bool
	var body: some View {
		if didInit {
			Text("No Upgrades Found")
				.font(.callout)
				.foregroundStyle(Color.accentColor)
				.bold()
		}
	}
}
