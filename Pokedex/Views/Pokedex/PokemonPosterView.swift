//
//  PokemonPosterView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-25.
//

import SwiftUI

struct PokemonPosterView: View {
	var pokemon: Pokemon
	@Binding var selection: Menu

	var body: some View {
		VStack() {
			Spacer()
			HStack(spacing: 48){
			PokedexService().getImage(id: pokemon.id)
					.scaledToFit()
					.frame(width: 136)
				InfosView(pokemon: pokemon, detail:true)
			}
			.padding(.leading)
			.padding(.bottom, 36)
			MenuPickerView(selection: $selection)
		}
			.frame(height: 420)
			.ignoresSafeArea()
			.background(
				LinearGradient(
					gradient: Gradient(colors: [
						PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.5),
						PokemonType(rawValue: pokemon.types.first ?? "normal")!.color.opacity(0.8)
					]),
					startPoint: .top,
					endPoint: .bottom
				)
				.ignoresSafeArea()
			)
			.overlay{
				HoveringTextView(name: pokemon.name)
			}
		
	}
}



struct HoveringTextView: View {
	let name : String
	var body: some View {
		GeometryReader { geometry in
			Text("\(name)")
				.font(.system(size: 100, weight: .bold))
				.foregroundColor(Color.white.opacity(0.175))
				.minimumScaleFactor(0.1)
				.lineLimit(1)
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
		}
		.offset(x: 8, y: -52)
		.padding()
	}
}
