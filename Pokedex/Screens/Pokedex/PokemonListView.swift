import SwiftUI


// Créer un Service et Client pour votre Pokédex API:
//  - https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons?limit=151&lang=fr
//
// L'URL des images pour les Pokémon est: "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/001.png"
// AsyncImage est utilisé pour charger des images de manière asynchrone provenant d'un URL HTTP.
//  - On peut ajouter un placeholder qui est un ProgressView
//
// .offset() est utile pour déplacer un élément par rapport à lui même (sortir de son conteneur, etc.)

struct PokemonListView: View {
    // Only for example of calling API with AuthService --> AuthClient --> ApiClient
    // This example also show what the usernames and passwords are
    private let authService = AuthService()
    
    @State private var users: [User] = []
    
    // NOTE: This is only for demo. Any methods doing logic should be in a service and not directly in the UI
    func getPassword(_ user: User) -> String {
        return user.firstName.first!.uppercased() + user.lastName.first!.uppercased() + "2024"
    }
    
    var body: some View {
        Text("Écran de la liste de Pokémon")
            .bold()
        
        List(users) { user in
            VStack(alignment: .leading) {
                Text("\(user.firstName) \(user.lastName)")
                
                HStack {
                    Text(user.username)
                    Text("/")
                    Text(getPassword(user))
                }
                .foregroundStyle(.secondary)
            }
        }
        .onAppear {
            Task {
                users = await authService.getUsers()
            }
        }
    }
}

#Preview {
    PokemonListView()
}
