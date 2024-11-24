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
    var body: some View {
        Text("Écran de connexion")
        Form{
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            
            Button{
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.accentColor)
                    Text("Log In")
                        .foregroundStyle(.white)
                        .bold()
                }
            }
        }
        
    }
}

#Preview {
    LoginView()
}
