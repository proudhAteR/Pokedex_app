import Foundation

// NOTE: Pour l'API d'exemple des /users (https://mapi.cegeplabs.qc.ca/auth/v1/users)
// Il n'est pas nécessaire de faire un CodingKeys puisque le standard utilisé ici dans le JSON est le même que Swift
struct User: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let isActive: Bool
    let avatar: String
    let loginAttempts: Int
    let createdAt: String
    let role: String
}
