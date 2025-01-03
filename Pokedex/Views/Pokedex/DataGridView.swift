//
//  DataGridView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct DataGridView: View {
	@Binding var details: Details?
	var body: some View {
		VStack(alignment:.leading, spacing: 16) {
			TitleSectionView(
				color: PokemonType(
					rawValue: details?.types.first ??  "normal"
				)!.color,
				title:"pokedex_datas_title"
			)
			DataGrid(details: $details)
		}
	}
}

struct DataGrid : View {
	@Binding var details: Details?
	var body : some View{
		LazyVGrid(columns: [
			GridItem(.fixed(132), alignment: .leading),
			GridItem(.flexible(), alignment: .leading)
		], spacing: 16) {
			GridTitleView(title: "Species")
			Text("\(details?.speciesName ?? "")")
			GridTitleView(title: "Height")
			Text("\(details?.height ?? 0)")
			GridTitleView(title: "Weight")
			Text("\(details?.weight ?? 0)")
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
