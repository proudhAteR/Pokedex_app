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
	@State var selection: Menu = .About
	var pokemon: Pokemon
	@State var details : Details? = nil
	var body: some View {
		GeometryReader{geo in
			VStack{
				PokemonPosterView(pokemon: pokemon, selection: $selection)
					.frame(height: geo.size.height * 0.4)
				TabView(selection: $selection){
					AboutView(details: $details, pokemon: pokemon)
						.tag(Menu.About)
					Text("B")
						.tag(Menu.Stats)
					Text("C")
						.tag(Menu.Upgrades)
				}

			}
			.onAppear{
				Task{
					details = await viewModel.getDetails(id: pokemon.id)
				}
			}
		}
		

	}
}



#Preview {
	@Previewable let pokemon = Pokemon(id: 25, name: "Pikachu", isFavorite: true, types: ["electric"])
	PokemonDetailView(pokemon: pokemon)
}



struct MenuPickerView: View {
	@Binding var selection : Menu
	var body: some View {
		Picker("Menu", selection: $selection){
			ForEach(Menu.allCases){ menu in
				Text("\(PokedexService().localizedMenu(for: menu))".capitalized)
					.tag(menu)
			}
		}
		.pickerStyle(.segmented)
	}
}
