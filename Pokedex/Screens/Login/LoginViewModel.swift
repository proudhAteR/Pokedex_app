import Foundation

// NOTE: Un ViewModel peut simplifier le code
class LoginViewModel: ObservableObject {
	@Published var isConnected: Bool = false
	@Published var isLoginShown : Bool = false
	let auth = AuthService()

	public func connect(username: String, password: String) async {
		do {
			let success = try await auth.connect(username: username, password: password)
			
			DispatchQueue.main.async {
				self.isConnected = success
			}
		} catch {
			print("Unable to connect to the API: \(error)")
		}
	}
	
	public func showLogin(){
		isLoginShown  = true
	}
}
