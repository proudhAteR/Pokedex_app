import Foundation

// NOTE: Un ViewModel peut simplifier le code
class LoginViewModel: ObservableObject {
	@Published var isConnected : Bool = false
	let auth = AuthService()
	
	public func connect(username: String, password: String) async{
		do{
			isConnected =  try await auth
				.connect(username: username, password: password)
		}catch{
			print("Unable to connect to the API: \(error)")
		}
	}
}
