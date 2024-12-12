//
//  PokemonView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct PokemonView: View {
	let pokemon : Pokemon
	var body: some View {
		HStack {
			HStack(spacing: 8) {
				InfosView(pokemon: pokemon)
				Spacer()
				PokedexService().getImage(id: pokemon.id)
					.frame(width: 132)
			}
			.padding()
		}
		.background(
			RoundedRectangle(cornerRadius: 15)
							.fill(PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.gradient.opacity(0.75))
		)
		.cornerRadius(20)
		.padding(.vertical, 10)
		.shadow(color: PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.5), radius: 4, y: 8)
	}
}



#Preview {
	@Previewable let pokemon = Pokemon(id: 25, name: "Pikachu", isFavorite: true, types: ["electric"])
	PokemonView(pokemon: pokemon)
}
