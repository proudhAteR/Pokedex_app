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
		TitleSectionView(
			color: PokemonType(rawValue: pokemon.types.first ?? "normal")?.color ?? .gray,
			title: "defense_type_title", subtitle: String(
				format: "Each type efficiancy on %@",
				pokemon.name.capitalized
			)
		)
		
		DefensesGrid(defenses: details?.defenses)
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
