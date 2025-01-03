import SwiftUI

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
// Pour bien partir le projet, je vous suggère de faire le setup initial :
//      1. Prendre les icônes des types fournis avec l'énoncé et les ajouter dans le catalogue d'Assets
//      2. Créer les Color Set pour les couleurs des types
//      3. Créer un fichier pour la localisation des textes (Localizable.xcstrings)
//          -  Pour avoir une clé avec interpolation de string, voir NSLocalizedString:
//            Text(NSLocalizedString("MyTypeKey.\(type)", comment: ""))
//
//      4. Selon les mockups, commencer à ajouter les textes nécessaires
//      5. Prendre le temps de regarder les endpoints d'API disponibles et de regarder le JSON retourné
//      6. Générer les struct pour les API (quicktype)
//      7. Mettre les protocoles nécessaires aux struct
//      8. N'oubliez pas le CodingKeys au besoin
//      9. Dans Preview Content, créer des données mock pour faciliter vos tests et vos previews
//      10. Des ViewModels vides ont été créés, il n'est pas nécessaire de les utiliser, mais cela peut
//         aider à simplifier le code pour les 3 vues principaux (Login, List, Detail).
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
struct RootView: View {
	@EnvironmentObject var viewModel: LoginViewModel

	private var currentView: some View {
		Group {
			if isUserAuth {
				PokemonListView()
					.environmentObject(PokemonListViewModel())
			} else if isLoginShown {
				LoginView()
			} else {
				SplashView()
			}
		}
		.transition(.opacity)
	}

	private var isUserAuth: Bool {
		viewModel.isConnected
	}

	private var isLoginShown: Bool {
		viewModel.isLoginShown
	}

	private func isPageChanging() -> Bool {
		return isLoginShown || isUserAuth
	}
	
	var body: some View {
		ZStack {
			currentView
		}
		.animation(.easeInOut(duration: 0.5), value: isPageChanging())
	}
}



#Preview {
    RootView()
		.environmentObject(LoginViewModel())
}
