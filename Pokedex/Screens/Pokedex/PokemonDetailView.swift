import SwiftUI

//
// Je recommande fortement l'utilisation de LazyVGrid pour placer des éléments alignés en grid.
// C'est facile d'utilisation et cela permet de facilement placer n'importe quel élément.
//
// GeometryReader est utile pour pouvoir récupérer la taille de l'appareil et pouvoir faire un ratio pour
// une dimension. Par exemple, height*0.6 pour s'assurer que prendre 60% de la taille en tout temps.
//
// Un TabView personnalisé se fait avec l'utilisation de .tag() et une variable @State pour conserver l'état sélectionné
//  - Revoir l'exemple ChartsMVVM avec le Picker
//  - TabViewStyle peut être utile pour changer le style du TabView au besoin
//
// .clipShape() peut permettre de faire des shapes avec des coins arrondis, etc.
//

struct PokemonDetailView: View {
	@ObservedObject var viewModel = PokemonDetailViewModel()
	@State var selection: DetailMenu = .About
	var pokemon: Pokemon
	@State var details : Details? = nil
	var body: some View {
		GeometryReader{geo in
			VStack{
				PokemonPosterView(pokemon: pokemon, selection: $selection)
					.frame(height: geo.size.height * 0.4)
				TabView(selection: $selection){
					AboutView(details: $details)
						.tag(DetailMenu.About)
					StatsView(details: $details)
						.tag(DetailMenu.Stats)
					UpgradesView(details:$details)
						.tag(DetailMenu.Upgrades)
				}
				.tabViewStyle(.page(indexDisplayMode: .never))

			}
			.navigationBarTitle("\(details?.name ?? "")", displayMode: .inline)
			.onAppear{
				Task{
					if details == nil{
						details = await viewModel.getDetails(id: pokemon.id)
					}
				}
			}
		}
		
	}
}

#Preview {
	@Previewable let pokemon = Pokemon(id: 4, name: "Charmander", isFavorite: true, types: ["fire"])
	PokemonDetailView(pokemon: pokemon)
}



struct MenuPickerView: View {
	@Binding var selection : DetailMenu
	var body: some View {
		Picker("Menu", selection: $selection){
			ForEach(DetailMenu.allCases){ menu in
				Text("\(PokedexService().localizedMenu(for: menu))".capitalized)
					.tag(menu)
			}
		}
		.pickerStyle(.segmented)
	}
}
