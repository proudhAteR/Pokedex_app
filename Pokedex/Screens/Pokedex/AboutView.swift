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
			ScrollView{
				DescriptionView(description: details?.description ?? "Loading description...")				
				VStack(alignment:.leading, spacing: 16) {
					Text("pokedex_datas_title")
						.font(.headline)
						.foregroundColor(
							PokemonType(rawValue: pokemon.types.first ?? "normal")!.color
						)
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
				.padding()
				Spacer()
			}
		
	}
			
}


#Preview {
	PokemonListView()
}

struct DescriptionView: View {
	let description : String
	func formatDescription(description : String)-> String{
		return description.replacingOccurrences(of: "\n", with: " ")
			.replacingOccurrences(of: "\u{0C}", with: "")
	}
	var body: some View {

		Text(formatDescription(description: description))
			.font(.body)
			.foregroundColor(.gray)
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
