import SwiftUI

struct SplashView: View {
    // Pour faire un délai, vous pouvez utiliser l'événement onAppear et
    // exécuter un code asynchrone après X secondes en utilisant :
    //  - https://developer.apple.com/documentation/dispatch/dispatchqueue/2300020-asyncafter
    
    var body: some View {
        Text("Écran de démarrage pour l'application")
    }
}

#Preview {
    SplashView()
}
