import Foundation

class AuthClient {
    private let baseURL = "https://mapi.cegeplabs.qc.ca/auth/"
    
    func getUsers() async throws -> [User] {
        let url = "\(baseURL)v1/users"
        let users: [User] = try await ApiClient.shared.get(apiUrl: url)
        return users
    }
}
