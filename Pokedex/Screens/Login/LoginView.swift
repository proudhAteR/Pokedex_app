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
	@EnvironmentObject var viewModel : LoginViewModel
	var body: some View {
		VStack(spacing: 28) {
			LogoView()
				.padding(.top, 160)
			InputsView(username: $username, password: $password)
				.padding(.horizontal, 20)
			ButtonView(
				username: $username,
				password: $password
			)
			
		}
	}
	
	
}
#Preview {
	LoginView()
		.environmentObject(LoginViewModel())
}


struct ButtonView: View {
	@EnvironmentObject var viewModel : LoginViewModel
	@Binding var username : String
	@Binding var password : String
	@State private var showErrorAlert = false

	var body: some View {
		VStack {
			Button(
				action: {
					Task {
						await viewModel
							.connect(username: username, password: password)
						if !viewModel.isConnected{
							showErrorAlert = true
						}
					}
			}) {
				Text("login_button")
					.frame(maxWidth: .infinity, minHeight: 50)
					.foregroundColor(.white)
					.background(Color.accentColor)
					.cornerRadius(12)
					.padding(.horizontal, 20)
					.bold()
			}
			.padding(.top, 84)
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
	@Binding var username: String
	@Binding var password: String
	
	var body: some View {
		VStack(spacing: 24) {
			TextField("username_placeholder", text: $username)
				.textFieldStyle()
				.autocapitalization(.none)

			SecureField("password_placeholder", text: $password)
				.textFieldStyle()

		}
	}
}
extension View {
	func textFieldStyle() -> some View {
		self
			.padding(.horizontal, 20)
			.frame(maxWidth: .infinity, minHeight: 50)
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
