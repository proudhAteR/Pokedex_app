
import Foundation

struct Pokemon: Decodable, Identifiable {
	let id: Int
	let name: String
	let isFavorite: Bool
	let types: [String]

	enum CodingKeys: String, CodingKey {
		case id, name
		case isFavorite = "is_favorite"
		case types
	}
}





