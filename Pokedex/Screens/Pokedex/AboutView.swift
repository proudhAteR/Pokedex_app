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

struct DataGridView: View {
	@Binding var details: Details?
	let pokemon : Pokemon
	var body: some View {
		VStack(alignment:.leading, spacing: 16) {
			Text("pokedex_datas_title")
				.font(.headline)
				.foregroundColor(
					PokemonType(rawValue: pokemon.types.first ?? "normal")!.color
				)
				.padding(.bottom, 8)
			LazyVGrid(columns: [
				GridItem(.fixed(132), alignment: .leading),
				GridItem(.flexible(), alignment: .leading)
			], spacing: 16) {
				GridTitleView(title: "Species")
				Text("\(details?.speciesName ?? "B")")
				GridTitleView(title: "Height")
				Text("\(details?.height ?? 4)")
				GridTitleView(title: "Weight")
				Text("\(details?.weight ?? 80)")
				GridTitleView(title: "Weaknesses")
				HStack {
					ForEach(details?.weaknesses ?? [], id: \.self){ weakness in
						Image(PokemonType(rawValue: weakness)!.image)
							.resizable()
							.scaledToFit()
							.frame(width: 24, height: 24)
					}
				}
				
			}
		}
	}
}
