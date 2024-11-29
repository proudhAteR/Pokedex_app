//
//  AboutView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-26.
//

import SwiftUI

struct AboutView: View {
	@Binding var details: Details?
	let pokemon : Pokemon
	let columns = [GridItem(.flexible()), GridItem(.flexible())]
	var body: some View {
		VStack(alignment:.leading, spacing: 20) {
			DescriptionView(description: details?.description ?? "Loading description...")
			DataGridView(details: $details, pokemon: pokemon)
			
			Spacer()
		}
		.padding()

	}
			
}


#Preview {
	PokemonListView()
}

struct DescriptionView: View {
	let description : String
	func formatDescription(description : String)-> String{
		return description.replacingOccurrences(of: "\n", with: " ")
			.replacingOccurrences(of: "\u{0C}", with: " ")
	}
	var body: some View {
		Text(formatDescription(description: description))
			.foregroundStyle(.gray)

	}
}


struct GridTitleView: View {
	let title : String
	var body: some View {
		Text("\(title)")
			.bold()
			.lineLimit(1)
	}
}


