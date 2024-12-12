
import SwiftUI

struct TypeView: View {
	var type: String
	var filter : Bool = false
	var selectedTypes: Set<PokemonType> = []
	private func colorize() -> Bool {
		return selectedTypes
			.contains(PokemonType(rawValue: type)!) || !filter
	}
	
	var body: some View {
		let localizedTypeName = PokedexService().localizedType(for: type)
		HStack {
			Image(PokemonType(rawValue: type)!.image)
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20, alignment: .center)
			
			Text(localizedTypeName.capitalized)
				.font(.caption)
			
		}
		.frame(maxWidth: filter ? .infinity : nil)
		.lineLimit(1)
		.padding(filter ? 8 :4)
		.background(
			colorize() ? PokemonType(
					rawValue: type
				)!.color
			: .gray
		)
		.foregroundColor(.white)
		.cornerRadius(4)
	}
}

#Preview {
	TypeView(type: "poison")
}
