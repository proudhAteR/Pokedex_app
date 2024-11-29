//
//  PokemonType.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-24.
//

import Foundation
import SwiftUICore
import DeveloperToolsSupport

enum PokemonType: String, CaseIterable {
	case fire, water, grass, electric, flying, fighting
	case ghost, bug, dark, dragon, fairy, ground
	case ice, normal, poison, psychic, rock, steel

	var color: Color {
		switch self {
		case .fire: return .fire
		case .water: return .water
		case .grass: return .grass
		case .electric: return .electric
		case .flying: return .flying
		case .fighting: return .fighting
		case .ghost: return .ghost
		case .bug: return .bug
		case .dark: return .dark
		case .dragon: return .dragon
		case .fairy: return .fairy
		case .ground: return .ground
		case .ice: return .ice
		case .normal: return .normal
		case .poison: return .poison
		case .psychic: return .psychic
		case .rock: return .rock
		case .steel: return .steel
		}
	}
	var image : ImageResource{
		switch self {
		case .fire: return .fire
		case .water: return .water
		case .grass: return .grass
		case .electric: return .electric
		case .flying: return .flying
		case .fighting: return .fighting
		case .ghost: return .ghost
		case .bug: return .bug
		case .dark: return .dark
		case .dragon: return .dragon
		case .fairy: return .fairy
		case .ground: return .ground
		case .ice: return .ice
		case .normal: return .normal
		case .poison: return .poison
		case .psychic: return .psychic
		case .rock: return .rock
		case .steel: return .steel
		}
	}
}
