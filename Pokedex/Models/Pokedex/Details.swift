
import Foundation

struct Details: Decodable {
	let id: Int
	let name: String
	let isFavorite: Bool
	let types: [String]
	let weight, height, baseExperience: Int
	let description: String
	let stats: Stats
	let abilities: [Ability]
	let evolutions: [String]
	let speciesName: String
	let weaknesses: [String]
	let defenses: [Defense]
	
	enum CodingKeys: String, CodingKey {
		case id, name
		case isFavorite = "is_favorite"
		case types
		case weight, height
		case baseExperience = "base_experience"
		case description
		case stats
		case abilities
		case evolutions
		case speciesName = "species_name"
		case weaknesses
		case defenses
	}
}

// MARK: - Ability
struct Ability: Decodable {
	let name: String
}

// MARK: - Defense
struct Defense: Decodable {
	let type: String
	let multiplier: Double
}

// MARK: - Stats
struct Stats: Decodable {
	let hp, attack, defense, specialAttack: Int
	let specialDefense, speed: Int
	
	enum CodingKeys: String, CodingKey {
		case hp
		case attack
		case defense
		case speed
		case specialAttack = "special_attack"
		case specialDefense = "special_defense"
	}
}
