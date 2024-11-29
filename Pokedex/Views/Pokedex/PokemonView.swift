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
			PokemonRowView(pokemon: pokemon)
				.padding()
		}
		.background(
			LinearGradient(
				gradient: Gradient(colors: [
					PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.45),
					PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.75)
				]),
				startPoint: .top,
				endPoint: .bottom
			)
		)
		.cornerRadius(20)
		.padding(.vertical, 10)
		.shadow(color: PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.5), radius: 4, y: 8)
	}
}
struct PokemonRowView: View {
	var pokemon: Pokemon
	var body: some View {
		HStack(spacing: 8) {
			InfosView(pokemon: pokemon)
			Spacer()
			PokedexService().getImage(id: pokemon.id)
				.frame(width: 132)
		
		}
	}
}


#Preview {
	@Previewable let pokemon = Pokemon(id: 25, name: "Pikachu", isFavorite: true, types: ["electric"])
	PokemonDetailView(pokemon: pokemon)
}
