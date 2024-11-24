import Foundation


struct AuthRequest: Encodable {
	let username: String
	let password: String
}

struct AuthResponse: Decodable {
	let token: String
}
