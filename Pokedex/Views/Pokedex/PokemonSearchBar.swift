//
//  PokemonSearchBar.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-25.
//

import SwiftUI

struct PokemonSearchBar: View {
	@ObservedObject var viewModel = PokemonListViewModel()
	@Binding var query: String
	@Binding var pokemons: [Pokemon]
	@Binding var allPokemons: [Pokemon]

	private func makeSearch() {
		Task {
			pokemons = await viewModel.handleSearch(query: query)
		}
	}

	var body: some View {
		HStack(spacing: 12) {
			Button(action: {
				makeSearch()
			}) {
				Image(systemName: "magnifyingglass")
					.foregroundColor(.primary)
			}

			TextField(LocalizedStringKey("search_placeholder"), text: $query)
				.textInputAutocapitalization(.none)
				.foregroundColor(.primary)
				.padding(.vertical, 10)
				.padding(.horizontal, 5)
				.onSubmit {
					makeSearch()
				}

			Button(action: {
				print("QR Code tapped")
			}) {
				Image(systemName: "qrcode.viewfinder")
					.foregroundColor(.primary)
			}
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 10)
		.background(Color(.systemGray6))
		.cornerRadius(16)
		.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
	}
}
#Preview {
	PokemonListView()
}
