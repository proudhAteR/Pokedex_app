//
//  StatsView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct StatsView: View {
	@Binding var details: Details?
	let pokemon: Pokemon
	var body: some View {

		ScrollView{
			VStack(alignment: .leading, spacing: 12) {
				BarStatSectionView(pokemon: pokemon, details: $details)
					.padding(.bottom, 16)
				DefenseSectionView(details: $details, pokemon: pokemon)
			}
			.padding()
		}
	}
		 
	 private var pokemonPrimaryTypeColor: Color {
		 PokemonType(rawValue: pokemon.types.first ?? "normal")?.color ?? .gray
	 }
}



