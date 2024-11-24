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
    var body: some View {
        Text("Écran de connexion")
    }
}

#Preview {
    LoginView()
}
