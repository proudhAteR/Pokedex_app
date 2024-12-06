//
//  BarStatSectionView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct BarStatSectionView: View {
	@Binding var details : Details?
	var body: some View {
		TitleSectionView(
			color: PokemonType(
				rawValue: details?.types.first ??  "normal"
			)!.color,
			title:"base_stat_title"
		)
		StatGridView(details: $details)
		
	}
}
