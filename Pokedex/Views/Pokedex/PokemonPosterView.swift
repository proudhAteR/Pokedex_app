

import SwiftUI

struct PokemonPosterView: View {
	var pokemon: Pokemon
	@Binding var selection: DetailMenu

	var body: some View {
		VStack() {
			Spacer()
			HStack(spacing: 24){
			PokedexService().getImage(id: pokemon.id)
					.scaledToFit()
					.frame(width: 140)
				InfosView(pokemon: pokemon, detail:true)
			}
			.padding(.leading)
			.padding(.bottom, 36)
			MenuPickerView(selection: $selection)
		}
			.ignoresSafeArea()
			.background(
				LinearGradient(
					gradient: Gradient(colors: [
						PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.5),
						PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.8)
					]),
					startPoint: .top,
					endPoint: .bottom
				)
				.ignoresSafeArea()
			)
			.overlay{
				HoveringTextView(name: pokemon.name)
			}
		
	}
}



struct HoveringTextView: View {
	let name : String
	var body: some View {
		GeometryReader { geometry in
			Text("\(name)")
				.font(.system(size: 120, weight: .bold))
				.foregroundColor(Color.white.opacity(0.150))
				.minimumScaleFactor(0.1)
				.lineLimit(1)
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
		}
		.offset(x: 4, y: -96)
		.padding()
	}
}
