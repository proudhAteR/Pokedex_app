import Foundation

class AuthService {
    private let authClient = AuthClient()
    
    func getUsers() async -> [User] {
        do {
            let users: [User] = try await authClient.getUsers()
            return users
        } catch {
            print("Don't forget to handle errors correctly: \(error)")
            return []
        }
    }
}
