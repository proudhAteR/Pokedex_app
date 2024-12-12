import Foundation

class AuthService {
    private let authClient = AuthClient()
    
    func getUsers() async -> [User] {
        do {
            let users: [User] = try await authClient.getUsers()
            return users
        } catch {
            print("Unable to get users: \(error)")
            return []
        }
    }
	
	func connect(username : String, password : String) async throws-> Bool {
		if try await authClient.connect(username: username, password:password){
			return true
		}
		return false
	}
}
