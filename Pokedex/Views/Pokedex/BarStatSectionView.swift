//
//  BarStatSectionView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct BarStatSectionView: View {
	var pokemon : Pokemon
	@Binding var details : Details?
	var body: some View {
		TitleSectionView(
			color: PokemonType(
				rawValue: pokemon.types.first ??  "normal"
			)!.color,
			text:"base_stat_title"
		)
		StatGridView(pokemon: pokemon, details: $details)
		
	}
}
