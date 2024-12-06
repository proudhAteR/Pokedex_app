//
//  StatsView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct StatsView: View {
	@Binding var details: Details?
	var body: some View {

		ScrollView{
			VStack(alignment: .leading, spacing: 12) {
				BarStatSectionView(details: $details)
					.padding(.bottom, 12)
				DefenseSectionView(details: $details)
			}
			.padding()
		}
	}
		 
	 private var pokemonPrimaryTypeColor: Color {
		 PokemonType(rawValue: details?.types.first ?? "normal")?.color ?? .gray
	 }
}



