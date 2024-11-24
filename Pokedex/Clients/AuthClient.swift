import Foundation

class AuthClient {
	private let baseURL = "https://mapi.cegeplabs.qc.ca/auth/"
	
	func getUsers() async throws -> [User] {
		let url = "\(baseURL)v1/users"
		let users: [User] = try await ApiClient.shared.get(apiUrl: url)
		return users
	}
	func connect(username: String, password: String) async throws -> Bool {
		let url = "\(baseURL)v1/login"
		do {
			// Create the request object
			let authRequest = AuthRequest(username: username, password: password)
			
			// Perform the API call
			let response: AuthResponse = try await ApiClient.shared.post(
				apiUrl: url,
				body: authRequest,
				defaultResponse: AuthResponse(
					token: username
				)
			)
			print(response.token)
			return true
		} catch {
			return false
		}
	}

	
}
