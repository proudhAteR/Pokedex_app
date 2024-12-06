//
//  StatGridView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI


struct StatGridView : View {
	@Binding var details : Details?
	var body : some View {
		let columns = [
			GridItem(.fixed(100), alignment: .leading),
			GridItem(.fixed(50), alignment: .leading),
			GridItem(.flexible(), alignment: .leading)
		]
		LazyVGrid(columns: columns, spacing: 20) {
				StatGridRowView(details: details, text: "HP", value: details?.stats.hp ?? 0)
				StatGridRowView(details: details,text: "Attack", value: details?.stats.attack ?? 0)
				StatGridRowView(details: details,text: "Defense", value: details?.stats.defense ?? 0)
				StatGridRowView(details: details,text: "Sp. Attack", value: details?.stats.specialAttack ?? 0)
				StatGridRowView(details: details,text: "Sp. Defense", value: details?.stats.specialDefense ?? 0)
				StatGridRowView(details: details,text: "Speed", value: details?.stats.speed ?? 0)
			}
			.progressViewStyle(
				LinearProgressViewStyle(
					tint: PokemonType(rawValue: details?.types.first ?? "normal")!.color
							)
			)
	}
}


struct StatGridRowView: View {
	var details : Details?
	var text : String
	var value : Int
	var body: some View {
		Text("\(text)")
			.bold()
		Text("\(value)")
		ProgressView(
			value: Double(value),
			total: Double(details?.baseExperience ?? 500)
		)
		.cornerRadius(8)
	}
}

