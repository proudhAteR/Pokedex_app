//
//  DefenseSectionView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct DefenseSectionView: View {
	@Binding var details: Details?
	let pokemon: Pokemon
    var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			TitleSectionView(
				color: PokemonType(rawValue: pokemon.types.first ?? "normal")?.color ?? .gray,
				text: "defense_type_title"
			)
			Text(
				String(
					format: "Each type efficiancy on %@",
					pokemon.name.capitalized
				)
			)
			.foregroundStyle(.secondary)
			.font(.body)
			DefensesGrid(defenses: details?.defenses)
		}
    }
}

struct DefensesGrid: View {
 let rows = [GridItem(.fixed(50)), GridItem(.fixed(50))]
 let defenses: [Defense]?
 var body: some View {
			 if let defenses = defenses {
				 LazyHGrid(rows: rows) {
					 ForEach(defenses, id: \.type) { defense in
						 DefenseInfoView(defense: defense)
					 }
				 }
			 } else {
				 Text("No defenses available")
					 .foregroundColor(.secondary)
		 }
	}
 
}

 struct DefenseImage: View {
	 let type: String
	 
	 var body: some View {
		 Image(PokemonType(rawValue: type)?.image ?? .normal)
			 .resizable()
			 .scaledToFit()
			 .frame(width: 32, height: 28)
	 }
}


struct DefenseInfoView: View {
	let defense : Defense
	let viewModel = PokemonDetailViewModel()
	var body: some View {
		VStack {
			DefenseImage(type: defense.type)
			Text(
				"\(viewModel.formatMultiplier(mult: defense.multiplier))"
			)
			.font(.caption)
			.foregroundStyle(.secondary)
		}
	}
}
