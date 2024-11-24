import SwiftUI

struct LoginView: View {
	// Vous devez faire un formulaire de connexion pour que l'utilisateur puisse s'authentifier.
	// Quelques vues qui pourraient être utiles :
	//  1. Form
	//  2. TextField
	//  3. SecureTextField
	//  4. Button
	//
	// L'authentification se fera avec un appel à l'API:
	//      POST https://mapi.cegeplabs.qc.ca/auth/v1/login
	//
	@State var username = ""
	@State var password = ""
	@Binding var isConnected : Bool
	var body: some View {
		VStack(spacing: 28) {
			LogoView()
				.padding(.top, 160)
			InputsView(username: $username, password: $password)
				.padding(.horizontal, 20)
			ButtonView(
				isConnected: $isConnected,
				username: $username,
				password: $password
			)
			
		}
	}
	
	
}
#Preview {
	@Previewable @State var connected = false
	LoginView(isConnected: $connected)
}

struct ButtonView: View {
	@Binding var isConnected : Bool
	@Binding var username : String
	@Binding var password : String
	let authService = AuthService()
	@State private var showErrorAlert = false

	var body: some View {
		VStack {
			Button(
action: {
				Task {
					
					isConnected = try await authService
						.connect(
							username: username.lowercased(),
							password: password
						)
					print(isConnected)
					
					if !isConnected{
						showErrorAlert = true
					}
				}
			}) {
				Text("Login")
					.frame(maxWidth: .infinity, minHeight: 50)
					.foregroundColor(.white)
					.background(Color.accentColor)
					.cornerRadius(12)
					.padding(.horizontal, 20)
					.bold()
			}
			.padding(.top, 120)
		}
		.alert(isPresented: $showErrorAlert) {
			Alert(
				title: Text("Error"),
				message: Text("Please check your credentials or network connection."),
				dismissButton: .default(Text("OK"))
			)
		}
	}

}

struct InputsView: View {
	@Binding var username : String
	@Binding var password : String
	var body: some View{
		TextField("username_placeholder", text: $username)
			.padding()
			.background(Color(.systemGray6))
			.cornerRadius(12)
		
		SecureField("password_placeholder", text: $password)
			.padding()
			.background(Color(.systemGray6))
			.cornerRadius(12)
	}
}

struct LogoView: View {
	var body: some View {
		VStack {
			Image(.logo)
				.resizable()
				.scaledToFill()
		}
		.frame(maxWidth: .infinity, maxHeight: 60)

	}
}
