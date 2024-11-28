
import SwiftUI

struct TypeView: View {
	var type: String
	var detail : Bool = false
	var body: some View {
		let localizedTypeName = PokedexService().localizedType(for: type)
		HStack {
			Image(PokemonType(rawValue: type)!.image)
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20, alignment: .center)
			
			Text(localizedTypeName.capitalized)
				.font(detail ? .caption : .caption)
			
		}
		.lineLimit(1)
		.padding(.horizontal, 4)
		.padding(.vertical, 4)
		.background(PokemonType(rawValue: type)!.color)
		.foregroundColor(.white)
		.cornerRadius(4)
	}
}

#Preview {
	TypeView(type: "poison")
}
