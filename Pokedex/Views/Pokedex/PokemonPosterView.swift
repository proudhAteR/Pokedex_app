

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
			.padding(.bottom, 32)
			MenuPickerView(selection: $selection)
				.clipShape(RoundedRectangle(cornerSize: CGSize(width: 160, height: 160)))
		}
			.ignoresSafeArea()
			.background(
				RoundedRectangle(cornerRadius: 15)
				.fill(PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.gradient.opacity(0.75))
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
				.foregroundColor(Color.white.opacity(0.1))
				.minimumScaleFactor(0.1)
				.lineLimit(1)
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
		}
		.offset(x: 4, y: -96)
		.padding()
	}
}

#Preview {
	@Previewable let pokemon = Pokemon(id: 4, name: "Charmander", isFavorite: true, types: ["fire"])
	PokemonDetailView(pokemon: pokemon)
}
